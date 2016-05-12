from django import forms

from .models import FoodTopic

class FoodTopicForm(forms.ModelForm):

	class Meta:
		model = FoodTopic

