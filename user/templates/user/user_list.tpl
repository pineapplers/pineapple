{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% load thumbnail %}
{% block head %}
<link rel="stylesheet" href="{% static 'css/user_list.css' %}"></link>
{% endblock head %}
{% block content %}
 <div class="tab-container">
    <div class="user-item-container clearfix">
        {% if users %}
            {% for user in users %}
            <div class="user-item">
                <a href="{{ user.get_absolute_url }}">
                    {% thumbnail user.profile.avatar "65x65" as im %}
                    <div class="user-item-portrait" style="background-image: url('{{im.url}}')"></div>
                    {% empty %}
                    <div class="user-item-portrait"></div>
                    {% endthumbnail %}
                </a>
                <a href="{{ user.get_absolute_url }}"><span class="user-item-info">{{ user.username }}</span></a>
                <a href="{{ user.get_absolute_url }}"><button type="button" name="follow" class="user-item-follow-btn">查看资料</button></a>
            </div>
            {% endfor %}
        {% else %}
            {% if request.TAB == 'following' %}
                <p>ta还没关注任何人</p>
            {% else %}
                <p>ta还没被任何人关注</p>
            {% endif %}
        {% endif %}
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_list.js' %}"></script>
{% endblock js %}

