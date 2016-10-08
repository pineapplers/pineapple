from django import forms

from .models import ForumPost
from utils.mixins import CleanContentMixin


class ForumPostForm(forms.ModelForm, CleanContentMixin):
    class Meta:
        model = ForumPost
        fields = ('title', 'content')