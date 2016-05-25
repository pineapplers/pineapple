{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% block head %}
<title>好吃</title>
<link href="{% static 'css/food_list.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="list-container">
    <div class="list-tab-container">
        <ul class="tab-ul clearfix">
            <a href="{% url 'food:list' %}"><li class="tab-ul-item current-item">全部</li></a>
            {% for category in categorys %}
                <a href="{{ category.get_absolute_url }}"><li class="tab-ul-item">{{ category }}</li></a>
            {% endfor %}
        </ul>
    </div>

    <div class="list-main-container clearfix">
        {% for food in foods %}
        <div class="item">
            <a href="{{ food.get_absolute_url }}">
                <div class="item-img" style="background-image: url('{{ MEDIA_URL }}{{ food.cover_image }}')"></div>
            </a>
            <div class="item-main">
                <a href="#"><h3 class="item-title">{{ food.title }}</h3></a>
                <div class="item-tags">
                    <i class="fa fa-tags"></i>
                    {% for tag in food.tags.all %}
                        <span class="tag"><a href="#">{{ tag.name }}</a></span>
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
