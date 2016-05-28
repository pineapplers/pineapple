{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% load humanize %}
{% block head %}
<title>用户首页</title>
<link href="{% static 'css/user_index.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
    <div class="tab-container">
        <div class="timeline-container">
            {% with actions=actions %}
            {% if actions %}
                <div class="timeline-item-main">
                    {% for action in actions %}
                    <div class="timeline-item">
                        <i class="fa {{ action.get_action_class }}"></i>
                        <span class="timeline-item-username">{{ action.user }}</span>
                        <span class="timeline-item-action">{{ action.verb }}</span>
                        <span class="timeline-item-theme">{{ action.target }}</span>
                        <span class="timeline-item-time">{{ action.created | naturaltime}}</span>
                    </div>
                    {% endfor %}
                </div>
            {% else %}
                <p>ta最近还没有个人动态</p>
            {% endif %}
            {% endwith %}
        </div>
    </div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_index.js' %}"></script>
{% endblock js %}