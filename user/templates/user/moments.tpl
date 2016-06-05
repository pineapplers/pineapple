{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% load humanize %}
{% block head %}
<title>吃友圈</title>
<link href="{% static 'css/user_index.css' %}" rel="stylesheet">
<style type="text/css">
    a {
        text-decoration: none;
        color: #828caa;
    }
</style>
{% endblock head %}
{% block content %}
    <div class="tab-container">
        <div class="timeline-container">
            {% if actions %}
                <div class="timeline-item-main">
                    {% for action in actions %}
                    <div class="timeline-item">
                        <i class="fa {{ action.get_action_class }}"></i>
                        <span class="timeline-item-username">{{ action.user }}</span>
                        <span class="timeline-item-action">{{ action.verb }}</span>
                        <span class="timeline-item-theme"><a href="{{ action.target.get_absolute_url }}">{{ action.target }}</a></span>
                        <span class="timeline-item-time">{{ action.created | naturaltime}}</span>
                    </div>
                    {% endfor %}
                </div>
            {% else %}
                <p>ta最近还没有个人动态</p>
            {% endif %}
        </div>
    </div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_index.js' %}"></script>
{% endblock js %}