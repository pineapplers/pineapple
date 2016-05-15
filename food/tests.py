from django.core.files.images import ImageFile
from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import Client, TestCase

from user.models import User
from .models import Food, FoodCategory

# py 3.x+
from datetime import datetime
from unittest import mock

# Create your tests here.
class FoodTest(TestCase):
    def setUp(self):
        self.client = Client()
        test_user = User.objects.create_user(username='test', password='test123')
        category = FoodCategory()
        category.name = '默认'
        category.save()
        self.food = Food.objects.create(
            title='牛奶', 
            description='牛奶含有丰富的矿物质、钙、磷、铁、锌、铜、锰、钼。',
            # cover_image=mock.MagicMock(spec=ImageFile, name='FileMock'),
            cover_image=SimpleUploadedFile('test.jpg', 'testcontent'.encode()),
            link='',
            category=category,
            user=test_user
        )

    def test_created(self):
        self.assertTrue(isinstance(self.food.created, datetime))

    def test_category(self):
        self.assertEqual(self.food.category.name, '默认')

