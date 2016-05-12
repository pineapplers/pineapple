from haystack import indexes

from food.models import FoodItem


class FoodItemIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.CharField(document=True, use_template=True)
    title = indexes.DateTimeField(model_attr='title')

    def get_model(self):
        return FoodItem

    def index_queryset(self, using=None):
        return self.get_model().objects.all()
