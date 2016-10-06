from django import forms

from .models import FoodComment, ForumPostComment

class FoodCommentForm(forms.ModelForm):

    class Meta:
        model = FoodComment
        fields = ('content',)

class ForumPostCommentForm(forms.ModelForm):

    class Meta:
        model = ForumPostComment
        fields = ('content',)
