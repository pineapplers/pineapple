{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load thumbnail %}
{% block head %}
<title>好吃</title>
<link href="{% static 'css/food_list.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="list-container">
    <div class="list-tab-container">
        <ul class="tab-ul clearfix">
            <a href="{% url 'food:list' %}"><li class="tab-ul-item">全部</li></a>
            {% for category in categorys %}
                <a href="{{ category.get_absolute_url }}"><li class="tab-ul-item {% if category.name == section %}current-item{% endif %}">{{ category }}</li></a>
            {% endfor %}
        </ul>
    </div>

    <div class="list-main-container clearfix">
        {% for food in foods %}
        <div class="item">
            <a href="{{ food.get_absolute_url }}">
                {% thumbnail food.cover_image "300x200" crop="center" as im %}
                    <div class="item-img" style="background-image: url('{{ im.url }}')"></div>
                {% endthumbnail %}
            </a>
            <div class="item-main">
                <a href="#"><h3 class="item-title">{{ food.title }}</h3></a>
                <div class="item-tags">
                    <i class="fa fa-tags"></i>
                    {% for tag in food.tags.all %}
                        <span class="tag"><a href="{% url 'food:tag' tag=tag.name %}">{{ tag.name }}</a></span>
                    {% endfor %}
                </div>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/food_list.js' %}"></script>
{% endblock js %}
