from django import forms
from django.contrib.auth import authenticate
from django.core.exceptions import PermissionDenied

from .models import User, UserProfile, UserSetting

from utils.form import RegexPassWordField


class UserCacheMixin(object):
    def __init__(self, *args, **kwargs):
        self.user_cache = None

    def get_authenticated_user(self):
        return self.user_cache


class LoginForm(forms.ModelForm, UserCacheMixin):

    def clean(self):
        username = self.cleaned_data.get('username')
        password = self.cleaned_data.get('password')

        if username and password:
            self.user_cache = authenticate(username=username, password=password)
            if self.user_cache is None:
                raise forms.ValidationError('用户名或者密码不正确')
            elif not self.user_cache.is_active:
                raise forms.ValidationError('用户已被锁定')

        return self.cleaned_data

    class Meta:
        model = User
        fields = ('username', 'password')


class RegisterForm(forms.ModelForm, UserCacheMixin):
    password = RegexPassWordField('密码')
    confirm_password = RegexPassWordField('确认密码')

    def clean(self):
        username = self.cleaned_data.get('username')
        email = self.cleaned_data.get('email')
        password = self.cleaned_data.get('password')
        confirm_password = self.cleaned_data.get('confirm_password')

        if username and email and password and confirm_password:
            if password != confirm_password:
                raise forms.ValidationError('两次输入的密码不一致')
            elif User.objects.filter(username=username).exists():
                raise forms.ValidationError('该用户已经存在')

            User.objects.create_user(username=username, email=email, password=password)
            self.user_cache = authenticate(username=username, password=password)

        return self.cleaned_data

    class Meta:
        model = User
        fields = ('username', 'email', 'password', 'confirm_password')


class SettingForm(forms.ModelForm):

    class Meta:
        model = UserSetting
        exclude = ()


class ProfileForm(forms.ModelForm):

    class Meta:
        model = UserProfile
        fields = ('avatar', 'gender', 'date_of_birth', 'location', 'introduction')
        widgets = {
            'date_of_birth': forms.SelectDateWidget(years=range(1916, 2017), attrs={'class': 'selections'})
        }
