from django import forms

from .models import FoodComment

class FoodCommentForm(forms.ModelForm):

    class Meta:
        model = FoodComment
        fields = ('content',)
