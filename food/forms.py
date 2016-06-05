from django import forms

from .models import Food
from taggit.forms import TagWidget


class FoodForm(forms.ModelForm):

    def __init__(self, *args, **kwargs):
        super(FoodForm, self).__init__(*args, **kwargs)
        self.fields['tags'].required = True

    def clean_tags(self):
        tags = self.cleaned_data['tags']
        print(tags)
        if len(tags) > 5:
            raise forms.ValidationError('最多只能输入5个标签')
        return tags

    class Meta:
        model = Food
        fields = ('title', 'description', 'cover_image', 'link', 'category', 'tags')        
        # widgets = {
        #     'tags': TagWidget(),
        # }
