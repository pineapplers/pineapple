{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load thumbnail %}
{% block head %}
<title>首页</title>
<link href="{% static 'css/home_index.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="container" id="container">
    <div class="container-top">
        <div class="desc">
            <div class="desc-main">
                一起分享和发现好吃的
            </div>
        </div>
        <div class="pineapple-logo">
            Pineapple
        </div>
    </div>
</div>

<div class="topic-container">
    <div class="topic-container-title">
        <h1><span class="title-hr"></span>精选专题<span class="title-hr"></span></h1>
    </div>
    <div class="topic-container-main">
        {% for topic in topics %}
        <div class="topic-item">
            <a href="{{ topic.get_absolute_url }}">
                {% thumbnail topic.cover_image "393x188" crop="center" as im %}
                    <div class="topic-item-img" style="background-image: url('{{ im.url }}')"></div>
                {% endthumbnail %}
            <div class="topic-item-desc">
                <a href="#"><h3 class="desc-title">{{ topic.title }}</h3></a>
                <a href="#"><h4 class="desc-content">{{ topic.description }}</h4></a>
            </div>
            <div class="topic-item-info">
                <i class="fa fa-heart"><span class="num">{{ topic.total_collects }}</span></i>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/home_index.js' %}"></script>
{% endblock js %}
