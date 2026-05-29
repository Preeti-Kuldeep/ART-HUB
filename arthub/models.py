from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.utils import timezone
from datetime import timedelta
import uuid
from django.conf import settings

# --------------------------
# Custom User Manager
# --------------------------
class UserManager(BaseUserManager):
    def create_user(self, email, name, phone_number, password=None, user_type='buyer'):
        if not email:
            raise ValueError("Users must have an email address")
        email = self.normalize_email(email)
        user = self.model(
            email=email,
            name=name,
            phone_number=phone_number,
            user_type=user_type,
        )
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, name, phone_number, password=None, user_type='admin'):
        user = self.create_user(
            email=email,
            name=name,
            phone_number=phone_number,
            password=password,
            user_type=user_type
        )
        user.is_admin = True
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user

# --------------------------
# Custom User Model
# --------------------------
class User(AbstractBaseUser):
    USER_TYPES = (
        ('artist', 'Artist'),
        ('buyer', 'Buyer'),
        ('shopkeeper', 'Shopkeeper'),
        ('admin', 'Admin'),
    )

    name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    phone_number = models.CharField(max_length=10)
    user_type = models.CharField(max_length=20, choices=USER_TYPES)
    profile_image = models.ImageField(upload_to='profile_images/', default='profile_images/default.png', null=True, blank=True)
    description = models.TextField(blank=True, null=True)
    date_joined = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name', 'phone_number', 'user_type']

    objects = UserManager()

    def __str__(self):
        return self.name

    def has_perm(self, perm, obj=None):
        return self.is_admin

    def has_module_perms(self, app_label):
        return self.is_admin

    @property
    def is_staff(self):
        return self.is_admin

# --------------------------
# User Profile Model
# --------------------------
class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    phone_number = models.CharField(max_length=10)
    profile_image = models.ImageField(upload_to='profile_images/', blank=True, null=True)
    user_type = models.CharField(max_length=20)  # Could be changed to choices
    description = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.user.email

# --------------------------
# Product Model
# --------------------------
class Product(models.Model):
    CATEGORY_CHOICES = [
        ('Painting', 'Painting'),
        ('Art Material', 'Art Material'),
        ('Sketch', 'Sketch'),
        ('Digital Art', 'Digital Art'),
    ]

    seller = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    image = models.ImageField(upload_to='product_images/')
    price = models.DecimalField(max_digits=10, decimal_places=2)
    description = models.TextField()
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES, default='Painting')  # ✅ Added

    def __str__(self):
        return self.name

# Cart Model
# --------------------------
class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    added_at = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return f"{self.user.email} - {self.product.name} (x{self.quantity})"

    def get_total_price(self):
        return self.product.price * self.quantity

# --------------------------
# Purchase History Model
# --------------------------
class PurchaseHistory(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    purchased_at = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return f"{self.user.email} bought {self.product.name} (x{self.quantity})"

# --------------------------
# Order Model
# --------------------------
def get_default_delivery_date():
    return timezone.now().date() + timedelta(days=7)

class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    order_id = models.UUIDField(default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=100)
    email = models.EmailField()
    phone = models.CharField(max_length=10)
    address = models.TextField()
    payment_mode = models.CharField(max_length=50, default='Cash on Delivery')
    order_date = models.DateTimeField(default=timezone.now)
    expected_delivery_date = models.DateField(default=get_default_delivery_date)


# Then use it in your model:

def __str__(self):
        return f"Order #{self.order_id} for {self.product.name}"
