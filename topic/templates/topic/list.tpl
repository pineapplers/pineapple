{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load thumbnail %}
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
                {% thumbnail topic.cover_image "393x188" crop="center" as im %}
                    <div class="topic-item-img" style="background-image: url('{{ im.url }}')"></div>
                {% endthumbnail %}
            </a>
            <div class="topic-item-desc">
                <a href="{{ topic.get_absolute_url }}"><h3 class="desc-title">{{ topic.title }}</h3></a>
                <a href="#"><h4 class="desc-content">{{ topic.description }}</h4></a>
            </div>
            <div class="topic-item-info">
                
                <i class="fa fa-bookmark"><span class="num">{{ topic.total_collects }}</span></i>
                <a href="#" id="share-topic"><i class="fa fa-share-alt"></i></a>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/topic_list.js' %}"></script>
{% endblock js %}
