from celery import task
from django.contrib.auth.tokens import default_token_generator as dtg
from django.core.mail import send_mail

@task
def confirm_user(user):
    token = dtg.make_token(user) # timestamp默认为当天
    subject = 'confirm your account'.format(order.id)
    message = ''
    mail_sent = send_mail(subject, message, 'admin@xxx.com', [user.email])
    return mail_sent
