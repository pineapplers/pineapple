{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% block head %}
<title>想吃的</title>
<link href="{% static 'css/user_food_list.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
 <div class="tab-container">
    <div class="eat-container clearfix">
        {% for food in foods %}
        <div class="eat-item clearfix">
            <div class="food-image" style="background-image: url('{{ MEDIA_URL }}{{ food.cover_image }}')"></div>
            <div class="eat-item-main">
                <h3 class="food-title"><a href="#">{{ food.title }}</a></h3>
                <p class="food-desc">
                    {{ food.description }}
                </p>
                <div class="eat-item-icons">
                    <i class="fa fa-hand-peace-o"><span class="num">{{ food.rating.likes }}</span></i>
                    <a href="#"><i class="fa fa-share-alt"></i></a>
                </div>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_food_list.js' %}"></script>
{% endblock js %}