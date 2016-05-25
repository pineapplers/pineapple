{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% block head %}
<title>专题</title>
<link href="{% static 'css/topic_list.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="topic-container">
    <div class="topic-container-main">
        {% for topic in topics %}
        <div class="topic-item">
            <a href="{{ topic.get_absolute_url }}">
                <div class="topic-item-img" style="background-image: url('{{ MEDIA_URL }}{{ topic.cover_image }}')"></div>
            </a>
            <div class="topic-item-desc">
                <a href="#"><h3 class="desc-title">{{ topic.title }}</h3></a>
                <a href="#"><h4 class="desc-content">{{ topic.description }}</h4></a>
            </div>
            <div class="topic-item-info">
                
                <i class="fa fa-comments"><span class="num">{{ topic.total_collects }}</span></i>
                <a href="#"><a href="#"><i class="fa fa-share-alt"></i></a></a>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/topic_list.js' %}"></script>
{% endblock js %}
