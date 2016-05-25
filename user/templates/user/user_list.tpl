{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% block head %}
<link rel="stylesheet" href="{% static 'css/user_list.css' %}"></link>
{% endblock head %}
{% block content %}
 <div class="tab-container">
    <div class="user-item-container clearfix">
        {% for user in users %}
        <div class="user-item">
            <a href="#"><div class="user-item-portrait"></div></a>
            <a href="#"><span class="user-item-info">{{ user.username }}</span></a>
            <a href="#"><button type="button" name="follow" class="user-item-follow-btn">关注</button></a>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_list.js' %}"></script>
{% endblock js %}

