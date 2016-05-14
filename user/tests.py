from django.conf import settings
from django.core.urlresolvers import reverse
from django.test import Client, TestCase

from .models import User
from .forms import LoginForm, RegisterForm

# Create your tests here.
class AccountTest(TestCase):
    def setUp(self):
        self.client = Client()
        self.test_user = User.objects.create_user(username='test', password='test123')
        self.register_data = {
            'username': 'test1',
            'password': 'test123',
            'confirm_password': 'test123',
            'email': ''
        }
        self.login_data = {
            'username': 'test',
            'password': 'test123',
        }

    def test_user_settings_without_login(self):
        response = self.client.get(reverse('user:settings'))
        self.assertEquals(response.status_code, 302)
        self.assertTrue(response.url.startswith(str(settings.LOGIN_URL)))

    def test_user_profile_without_login(self):
        response = self.client.get(reverse('user:profile'))
        self.assertEquals(response.status_code, 302)
        self.assertTrue(response.url.startswith(str(settings.LOGIN_URL)))

    def test_register_form(self):
        sign_up_form = RegisterForm(self.register_data)
        self.assertTrue(sign_up_form.is_valid())

    def test_register(self):
        response = self.client.post(reverse('user:register'), self.register_data)
        self.assertEquals(User.objects.count(), 2)

    def test_login_form(self):
        login_form = LoginForm(self.login_data)
        self.assertTrue(login_form.is_valid())

    def test_login_in(self):
        response = self.client.post(reverse('user:login'), self.login_data)
        self.assertEquals(response.status_code, 302)
        self.assertTrue(self.test_user.is_authenticated())

    def test_if_user_have_setting(self):
        self.assertTrue(hasattr(self.test_user, 'settings'))

    def test_if_user_have_profile(self):
        self.assertTrue(hasattr(self.test_user, 'profile'))

    def test_user_follow(self):
        test_user = self.test_user
        follow_user = User.objects.create_user(username='abc', password='abc123')
        test_user.following.add(follow_user)
        self.assertEquals(follow_user.followers.count(), 1)
        self.assertEquals(follow_user.followers.first(), test_user)
        self.assertEquals(test_user.following.first(), follow_user)
        # self.client.get(reverse('user:following', kwargs={'user_id': follow_user.id}))



