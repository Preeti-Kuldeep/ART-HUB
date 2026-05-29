from django import forms
from django.contrib.auth.forms import UserCreationForm  # Correct import
from .models import User, Product, Order, UserProfile
#from django.contrib.auth.models import User 
from arthub.models import User   
 # Keep this for the User model

USER_TYPE_CHOICES = [
    ('artist', 'Artist'),
    ('shopkeeper', 'Shopkeeper'),
    ('buyer', 'Buyer'),
]

class SignupForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    confirm_password = forms.CharField(widget=forms.PasswordInput)
    user_type = forms.ChoiceField(choices=USER_TYPE_CHOICES)

    class Meta:
        model = User
        fields = ['name', 'phone_number', 'email', 'password', 'confirm_password', 'user_type']

    def clean(self):
        cleaned_data = super().clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")
        if password != confirm_password:
            self.add_error('confirm_password', "Passwords do not match.")
        return cleaned_data

    def save(self, commit=True):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data['password'])  # Hashing password
        if commit:
            user.save()
        return user

    
# Product Upload Form
class ProductForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = ['name', 'category', 'description', 'price','image']  
        widgets={'description': forms.Textarea(attrs={'rows': 3})}

class ProfileEditForm(forms.ModelForm):
     profile_image = forms.ImageField(required=False)

     class Meta:
        model = UserProfile
        fields = ['description', 'profile_image']  
       

        widgets = {
            'description': forms.Textarea(attrs={
                'rows': 4,
                'class': 'form-control',
                'placeholder': 'Tell us about yourself or your art style...',
            }),
            
            'profile_image': forms.ClearableFileInput(attrs={'class': 'form-control'}),
            
        }
class OrderForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = ['product', 'user', 'name', 'email', 'phone', 'address', 'payment_mode']