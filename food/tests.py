from django.core.urlresolvers import reverse
from django.core.files.images import ImageFile
from django.core.files.storage import Storage
from django.core.paginator import Page
from django.db.models.query import QuerySet
from django.test import Client, TestCase

from user.models import User
from .models import Food, FoodCategory
# py 3.x+
from datetime import datetime
from unittest import mock

import json

# Create your tests here.
class FoodTest(TestCase):
    def setUp(self):
        self.client = Client()
        self.test_user = User.objects.create_user(username='test', password='test123')
        self.client.login(username='test', password='test123')
        category = FoodCategory()
        category.name = '默认'
        category.save()

        img_mock = mock.MagicMock(spec=ImageFile, name='FileMock')
        img_mock.name = 'test.jpg'

        storage_mock = mock.MagicMock(spec=Storage, name='StorageMock')
        # storage_mock.url = mock.MagicMock(name='url')
        # storage_mock.url.return_value = '/tmp/test1.jpg'

        with mock.patch('django.core.files.storage.default_storage._wrapped', storage_mock):
            self.food = Food.objects.create(
                title='牛奶', 
                description='牛奶含有丰富的矿物质、钙、磷、铁、锌、铜、锰、钼。',
                cover_image=img_mock,
                link='',
                category=category,
                user=self.test_user
            )

    def test_created(self):
        self.assertTrue(isinstance(self.food.created, datetime))

    def test_category(self):
        self.assertEqual(self.food.category.name, '默认')

    def test_food_detail(self):
        response = self.client.get(reverse('food:detail', kwargs={'food_id': self.food.id}))
        ctx = response.context
        self.assertEqual(response.status_code, 200)
        self.assertTrue(isinstance(ctx['similar_foods'], QuerySet))

    def test_food_category(self):
        response = self.client.get(reverse('food:category', kwargs={'category': '默认'}))
        ctx = response.context
        self.assertTrue(isinstance(ctx['foods'], Page))

    def test_food_tag(self):
        response = self.client.get(reverse('food:tag', kwargs={'tag': ''}))
        ctx = response.context
        self.assertTrue(isinstance(ctx['foods'], Page))

    def test_foods_most_popular(self):
        response = self.client.get(reverse('food:explore'))
        ctx = response.context
        self.assertTrue(isinstance(ctx['most_viewed'], list))

    def test_food_like(self):
        response = self.client.post(reverse('food:like'), {'id': self.food.id, 'action': 'like'},
                HTTP_X_REQUESTED_WITH='XMLHttpRequest')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(self.food.users_like.count(), 1)
        self.assertEqual(self.food.users_dislike.count(), 0)

    def test_food_dislike(self):
        response = self.client.post(reverse('food:like'), {'id': self.food.id, 'action': 'dislike'},
                HTTP_X_REQUESTED_WITH='XMLHttpRequest')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(self.food.users_like.count(), 0)
        self.assertEqual(self.food.users_dislike.count(), 1)

    def test_food_wta(self):
        response = self.client.post(reverse('food:wta'), {'id': self.food.id},
                HTTP_X_REQUESTED_WITH='XMLHttpRequest')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(self.test_user.foods_wta.first(), self.food)

    def test_food_wta(self):
        response = self.client.post(reverse('food:ate'), {'id': self.food.id},
                HTTP_X_REQUESTED_WITH='XMLHttpRequest')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(self.test_user.foods_ate.first(), self.food)

