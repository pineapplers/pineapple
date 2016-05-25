{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% block head %}
<title>发现</title>
<link href="{% static 'css/food_explore.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="explore-container">
    <div class="explore-tab-container">
        <ul class="tab-ul clearfix">
            <a href="{% url 'food:explore' %}"><li class="tab-ul-item {% if request.SUBTAB == 'new' %}current-item{% endif %}">最新</li></a>
            <a href="{% url 'food:hot' %}"><li class="tab-ul-item {% if request.SUBTAB == 'hot' %}current-item{% endif %}">热门</li></a>
        </ul>
    </div>

    <div class="explore-main-container">
        {% for food in foods %}
        <div class="item">
            <a href="{{ food.get_absolute_url }}">
                <div class="item-img" style="background-image: url('{{ MEDIA_URL }}{{ food.cover_image }}')">
                    <div class="item-main">
                        <h4 class="item-title">{{ food.title }}</h4>
                        <div class="item-bottom">
                            <div class="item-create-user">
                                分享自 {{ food.user }}
                            </div>
                            <div class="icons">
                                <i class="fa fa-smile-o"><span class="like-num">{{ food.rating.likes }}</span></i>
                                <i class="fa fa-frown-o"><span class="dislike-num">{{ food.rating.dislikes }}</span></i>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/food_explore.js' %}"></script>
{% endblock js %}