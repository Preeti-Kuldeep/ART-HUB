from django.contrib import admin
from django.urls import path
from arthub import views  # Import your app views
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('admin/', admin.site.urls),

    # Authentication
    path('signup/', views.signup_view, name='signup'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.custom_logout, name='logout'),
    #path('search/', views.search_result, name='search_result'),


    # Main Pages
    path('home/', views.home_view, name='home'),
    path('seller/profile/', views.seller_profile, name='seller_profile'),
    path('edit-profile/', views.edit_profile, name='edit_profile'),

    # Product Pages
    path('upload/', views.upload_product, name='upload_product'),
    path('product/<int:product_id>/', views.product_detail, name='product_detail'),

    # Cart and Purchase Actions
    path('add-to-cart/<int:product_id>/', views.add_to_cart, name='add_to_cart'),
    path('remove-from-cart/<int:product_id>/', views.remove_from_cart, name='remove_from_cart'),
    path('cart/', views.view_cart, name='view_cart'),
    path('buy-now/<int:product_id>/', views.buy_now, name='buy_now'),
    path('sellers/', views.seller_list, name='seller_list'),
    path('seller/<int:seller_id>/', views.view_seller_profile, name='view_seller_profile'),
    path('shop/', views.shop_view, name='shop'),
    path('place-order/<int:product_id>/', views.place_order, name='place_order'),
    path('order_success/<int:order_id>/', views.order_success, name='order_success'),

]

# Serve media files (uploaded images) during development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)