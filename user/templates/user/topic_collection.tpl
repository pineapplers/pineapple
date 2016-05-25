{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% block head %}
<link rel="stylesheet" href="{% static 'css/user_topic_collection.css' %}"></link>
{% endblock head %}
{% block content %}
 <div class="tab-container">
    <div class="topic-container clearfix">
        {% for topic in collections %}
        <div class="topic-item clearfix">
            <div class="topic-item-image-container">
                <a href="{{ topic.get_absolute_url }}"><div class="topic-item-image" style="background-image: url('{{ MEDIA_URL }}{{ topic.cover_image }}')"></div></a>
            </div>
            <h4 class="topic-item-title">
                <a href="#">{{ topic.title }}</a>
            </h4>
            <div class="topic-item-icons">
                <i class="fa fa-bookmark"><span class="num">{{ topic.total_collects }}</span></i>
            </div>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_topic_collection.js' %}"></script>
{% endblock js %}
