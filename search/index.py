from haystack import indexes

from food.models import Food


class FoodIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.CharField(document=True, use_template=True)
    title = indexes.CharField(model_attr='title')
    description = indexes.TextField(model_attr='description')

    def get_model(self):
        return Food

    def index_queryset(self, using=None):
        return self.get_model().objects.all()
