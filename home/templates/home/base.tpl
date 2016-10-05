{% load staticfiles %}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="{% static 'font/font-awesome-4.5.0/css/font-awesome.min.css' %}" media="screen" title="no title" charset="utf-8">
        <link href="{% static 'css/vendors.css' %}" rel="stylesheet">
        {% block head %}
        {% endblock head %}
        </head>
    <body>
        {% include 'home/navbar.tpl' %}
        {% block content %}
        {% endblock content %}
        {% include 'user/chat.tpl' %}
    <script src="{% static 'js/vendors.js' %}"></script>
    <script src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="{% static 'js/csrf.js' %}"></script>
    <script src="{% static 'js/chat.js' %}"></script>
    {% block js %}
    {% endblock js %}
</body>
</html>
