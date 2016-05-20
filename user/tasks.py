from celery import task
from django.core import signing
from django.core.urlresolvers import reverse
from django.conf import settings
from django.core.mail import send_mail
from django.template.loader import render_to_string

@task
def confirm_user(id, username):
    token = signing.dumps({'user_id': id})
    url = reverse('user:confirm', kwargs={'token': token})
    subject = '{}, 激活你的帐户'.format(username)
    message = render_to_string('user/confirm.tpl', {'url': url})
    mail_sent = send_mail(subject, message, settings.EMAIL_HOST_USER, ['493632323@qq.com'])
    return mail_sent
