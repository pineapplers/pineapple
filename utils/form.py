from django import forms
from django.core.validators import RegexValidator

def RegexPassWordField(label):
    return forms.CharField(label=label,
        validators=[RegexValidator('^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d#?!@$%^&*+-]{6,32}$', 
            message="密码长度不少于6且至少包含一个字母和一个数字")],
        widget=forms.PasswordInput)