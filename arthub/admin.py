from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from .models import User, Product, Order, Cart, PurchaseHistory, UserProfile

# -------------------------------
# Custom User Admin
# -------------------------------
class UserAdmin(BaseUserAdmin):
    list_display = ('email', 'name', 'phone_number', 'user_type', 'is_admin')
    list_filter = ('user_type', 'is_admin')
    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Personal Info', {'fields': ('name', 'phone_number', 'user_type', 'profile_image', 'description')}),
        ('Permissions', {'fields': ('is_admin', 'is_active', 'is_superuser')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'name', 'phone_number', 'user_type', 'password1', 'password2'),
        }),
    )
    search_fields = ('email', 'name', 'phone_number')
    ordering = ('email',)
    filter_horizontal = ()

# -------------------------------
# Registering Models
# -------------------------------
admin.site.register(User, UserAdmin)
admin.site.register(Product)
admin.site.register(Order)
admin.site.register(Cart)
admin.site.register(PurchaseHistory)
admin.site.register(UserProfile)
