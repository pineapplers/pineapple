from django import forms

from .models import FoodComment, ForumPostComment
from utils.mixins import CleanContentMixin

class FoodCommentForm(forms.ModelForm):

    class Meta:
        model = FoodComment
        fields = ('content',)

class ForumPostCommentForm(forms.ModelForm, CleanContentMixin):

    class Meta:
        model = ForumPostComment
        fields = ('content',)