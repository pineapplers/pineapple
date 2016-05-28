from django import forms

from .models import Food
from taggit.forms import TagWidget


class FoodForm(forms.ModelForm):

    class Meta:
        model = Food
        exclude = ()
        widgets = {
            'tags': TagWidget(),
        }
