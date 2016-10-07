import bleach
from django.conf import settings
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

    def clean_content(self):
        content = self.cleaned_data.get('content', '')
        cleaned_text = bleach.clean(content, settings.BLEACH_VALID_TAGS, settings.BLEACH_VALID_ATTRS, settings.BLEACH_VALID_STYLES)
        return cleaned_text