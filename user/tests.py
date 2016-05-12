from django.test import TestCase

# Create your tests here.
class AccountTest(TestCase):
    def test_add(self):
        self.assertEquals(1 + 1, 2)