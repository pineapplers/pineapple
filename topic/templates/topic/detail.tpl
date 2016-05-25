{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% block head %}
<title>专题</title>
<link href="{% static 'css/topic_detail.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="details-container">
    <div class="topic-content">
        <div class="topic-img" style="background-image: url('{{ MEDIA_URL }}{{ topic.cover_image }}')"></div>
        <div class="topic-info">
            <h1 class="topic-title">{{ topic.title }}</h1>
            <div class="topic-desc">
                {{ topic.description }}
            </div>
        </div>
    </div>
    {% for food in foods %}
    <div class="detail-item">
        <a href="#">
            <div class="detail-img-left" style="background-image: url('{{ MEDIA_URL }}{{ food.cover_image }}')"></div>
        </a>
        <div class="detail-content">
            <h2 class="detail-title"><a href="{{ food.get_absolute_url }}">{{ food.title }}</a></h2>

            <div class="detail-desc-wrapper">
                <p class="detail-desc">
                    {{ food.description }}
                </p>
            </div>

            <div class="detail-bottom">
                <div class="detail-tags">
                    <span class="tags-tip">标签：</span>
                    {% for tag in food.tags.all %}
                        <i class="tag">{{ tag }}</i>
                    {% endfor %}

                    <div class="like">
                        <span class="like-count">{{ food.rating.likes }}</span>
                        <i class="fa fa-heart"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {% endfor %}
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/topic_detail.js' %}"></script>
{% endblock js %}
