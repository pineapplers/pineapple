{% load staticfiles %}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="{% static 'font/font-awesome-4.5.0/css/font-awesome.min.css' %}" media="screen" title="no title" charset="utf-8">
        <link href="{% static 'css/vendors.css' %}" rel="stylesheet">
        {% block head %}
        {% endblock head %}
        </head>
    <body>
        {% include 'home/navbar.tpl' %}
        {% block content %}
        {% endblock content %}
    <script src="http://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
    <script src="{% static 'js/vendors.js' %}"></script>
    {% block js %}
    {% endblock js %}
</body>
</html>
