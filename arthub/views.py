from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from .forms import SignupForm, ProductForm, ProfileEditForm, OrderForm
from django.http import JsonResponse
from .models import User, Product, Cart, Order
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.contrib.auth import get_user_model, login, logout
from django.contrib.auth.hashers import make_password
from django.utils import timezone
from django.utils.timezone import now
from uuid import uuid4
from datetime import timedelta
from django.db.models import Q
import random

# Signup View
def signup_view(request):
    if request.method == 'POST':
        form = SignupForm(request.POST)
        if form.is_valid():
            form.save()  # This will hash the password and save the user
            return redirect('login')  # Adjust as needed
        else:
            print("Form errors:", form.errors)
    else:
        form = SignupForm()
    return render(request, 'signup.html', {'form': form})



# Login View
def login_view(request):
    if request.method == 'POST':
        email = request.POST.get("email")
        password = request.POST.get("password")

        try:
            user = User.objects.get(email=email)
            if user.check_password(password):
                login(request, user)
                next_url = request.GET.get('next')
                if next_url:
                    return redirect(next_url)
                if user.user_type == 'artist' or user.user_type == 'shopkeeper':
                    return redirect('seller_profile')
                elif user.user_type == 'buyer':
                    return redirect('home')
                elif user.user_type == 'admin':
                    return redirect('/admin/')
                else:
                    messages.warning(request, "User type not recognized.")
                    return redirect('login')
            else:
                messages.error(request, "Incorrect password")
        except User.DoesNotExist:
            messages.error(request, "User not found")
    else:
        if request.GET.get('next'):
            messages.info(request, "Please login to access this page.")
    return render(request, 'login.html')

# Home View
def home_view(request):
    products = Product.objects.all() #.order_by('-uploaded_at')   Show latest first
    return render(request, 'home.html', {'products': products})

# Seller Profile View
@login_required
def seller_profile(request):
    if request.user.user_type not in ['artist', 'shopkeeper']:
        return redirect('home')  # prevent buyers from accessing

    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES)
        if form.is_valid():
            product = form.save(commit=False)
            product.uploaded_by = request.user
            product.save()
            return redirect('seller_profile')  # reload page
    else:
        form = ProductForm()

    #products = Product.objects.filter(uploaded_by=request.user)
    products = Product.objects.filter(seller=request.user)
    return render(request, 'seller_profile.html', {'form': form, 'products': products})

# Edit Profile View
@login_required
def edit_profile(request):
    if request.method == 'POST':
        form = ProfileEditForm(request.POST, request.FILES, instance=request.user)
        if form.is_valid():
            form.save()
            return redirect('seller_profile')
    else:
        form = ProfileEditForm(instance=request.user)
    return render(request, 'edit_profile.html', {'form': form})

# Product Detail View
def product_detail(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    return render(request, 'product_detail.html', {'product': product})

# Upload Product View
@login_required
def upload_product(request):
    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES)
        if form.is_valid():
            product = form.save(commit=False)
            product.seller = request.user
            product.save()
            return redirect('view_seller_profile', seller_id=request.user.id)
    else:
        form = ProductForm()
    return render(request, 'upload_product.html', {'form': form}) 
#def upload_product(request):
 ##      form = ProductForm(request.POST, request.FILES)
   #     if form.is_valid():
    #        product = form.save(commit=False)
     #       product.uploaded_by = request.user
      #      product.save()
       #     messages.success(request, "Product uploaded successfully!")
        #    return redirect('seller_profile')
   # else:
    #    form = ProductForm()
    #return render(request, 'upload_product.html', {'form': form})

# Logout View
#def logout_view(request):
 #   logout(request)
  #  return redirect('home')

def custom_logout(request):
    logout(request)
    return redirect('login')

# Add to Cart (temporary mock function)
@login_required(login_url='/login/')
def add_to_cart(request, product_id):
    if request.method == 'POST':
        product = get_object_or_404(Product, id=product_id)
        Cart.objects.get_or_create(user=request.user, product=product)
        #return JsonResponse({'message': 'Product added to cart', 'action': 'added'})
        return redirect('view_cart')

@csrf_exempt
@login_required
def remove_from_cart(request, product_id):
    if request.method == 'POST':
        cart_item = Cart.objects.filter(user=request.user, product_id=product_id).first()
        if cart_item:
            cart_item.delete()
            return JsonResponse({'message': 'Product removed from cart', 'action': 'removed'})
        else:
            return JsonResponse({'message': 'Product not found in cart'}, status=404)
    return JsonResponse({'error': 'Invalid request'}, status=400)


@login_required(login_url='/login/')
def view_cart(request):
    cart_items = Cart.objects.filter(user=request.user)
    total_price = sum(item.product.price * item.quantity for item in cart_items)

    order_history = Order.objects.filter(user=request.user).order_by('-order_date')

    return render(request, 'cart.html',{
        'cart_items': cart_items,
        'total_price': total_price,
        'order_history': order_history
        })

# Buy Now (temporary mock function)
@login_required
def buy_now(request, product_id):
    return HttpResponse("Buy now clicked (mock).")

User = get_user_model()

@login_required(login_url='/login/')
def seller_list(request):
    artists = User.objects.filter(user_type='artist')
    shopkeepers = User.objects.filter(user_type='shopkeeper')
    return render(request, 'seller_list.html', {'artists': artists, 'shopkeepers': shopkeepers})

@login_required(login_url='/login/')
def view_seller_profile(request, seller_id):
    seller = get_object_or_404(User, id=seller_id)
    products = Product.objects.filter(uploaded_by=seller)
    return render(request, 'view_seller_profile.html', {'seller': seller, 'products': products})
def view_seller_profile(request, seller_id):
    seller = get_object_or_404(User, id=seller_id)
    products = Product.objects.filter(seller=seller)

    # ✅ Filter by selected category
    category = request.GET.get('category')
    if category:
        products = products.filter(category=category)

    # ✅ Unique categories for dropdown
    categories = Product.objects.filter(seller=seller).values_list('category', flat=True).distinct()

    return render(request, 'view_seller_profile.html', {
        'seller': seller,
        'products': products,
        'categories': categories
    })


def shop_view(request):
    paintings = Product.objects.filter(category='painting')
    materials = Product.objects.filter(category='material')
    return render(request, 'shop.html', {
    'paintings': paintings,
        'materials': materials
    })

@login_required
def buy_now(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    
    # Generate fake order ID for display (replace this with actual Order model logic)
    order_id = f"ORD{random.randint(10000, 99999)}"
    order_date = timezone.now().date()
    delivery_date = order_date + timedelta(days=5)

    return render(request, 'buy_now.html', {
        'product': product,
        'order_id': order_id,
        'order_date': order_date,
        'delivery_date': delivery_date
    })

def place_order(request,product_id):
    if request.method == 'POST':
        user = request.user
        product_id = request.POST['product_id']
        product = Product.objects.get(id=product_id)

        name = request.POST['name']
        email = request.POST['email']
        phone = request.POST['phone']
        address = request.POST['address']
        payment_mode = "Cash on Delivery"
        order_date = timezone.now()
        expected_delivery_date = timezone.now().date() + timedelta(days=5)

        order = Order.objects.create(
            user=user,
            product=product,
            name=name,
            email=email,
            phone=phone,
            address=address,
            payment_mode=payment_mode,
            order_date=order_date,
            expected_delivery_date=expected_delivery_date
        )

        return redirect('order_success', order_id=order.id)
    return redirect('view_cart')  # fallback if GET request

def order_success(request, order_id):
    order = get_object_or_404(Order, id=order_id)
    return render(request, 'order_success.html', {'order': order})

def remove_from_cart(request, product_id):
    try:
        product = Product.objects.get(id=product_id)
        cart_item = Cart.objects.get(user=request.user, product=product)
        cart_item.delete()
        messages.success(request, "Product removed from cart.")
    except (Product.DoesNotExist, Cart.DoesNotExist):
        messages.error(request, "Product not found in cart.")
    
    return redirect('view_cart') 