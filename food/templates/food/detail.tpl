{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load widget_tweaks %}
{% block head %}
<title>发现</title>
<link href="{% static 'css/food_detail.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="detail-container">
    <div class="main-container clearfix">
        <div class="food-left fl">
            <div class="food-left-container">
                <div class="food-img">
                    <img src="{{ MEDIA_URL }}{{ food.cover_image }}" alt="商品图片" width="100%" height="100%">
                    <div class="food-img-shadow">
                        <div class="shadow-icons">
                            <div class="icon clicked">
                                <a href="#">
                                    <i class="fa fa-cutlery">
                                        <span class="fa-margin">想吃</span>
                                    </i>
                                </a>
                            </div>

                            <div class="icon">
                                <a href="#">
                                    <i class="fa fa-hand-peace-o">
                                        <span class="fa-margin">吃过</span>
                                    </i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="food-like-share">
                    
                    <div class="circle liked">
                        <i class="fa fa-heart"></i>
                    </div>
                    <div class="circle">
                        <i class="fa fa-share-alt"></i>
                    </div>
                </div>
            </div>

            <div class="comments-container">
                <div class="comments-wraaper clearfix">
                    <form method="post" action=".">
                        {% csrf_token %}
                        {{ comment_form.content | add_class:"comments-area" }}
                        <button type="button" name="sendBtn" class="send-btn">发表评论</button>
                    </form>
                </div>
                <h2 class="comments-title">全部评论</h2>
                <div class="comments-main">
                    {% for comment in comments %}
                    <div class="comments-item clearfix">
                        <div class="comments-user-img" style="background-image: url('/public/static/images/food2.jpg')"></div>
                        <div class="comments-user-name">
                            <span class="name"><a href="#">{{ comment.user }}</a></span>
                            <span class="comments-time">{{ comment.created| date:"Y-m-d H:m" }}</span>
                        </div>
                        <div class="comments-item-content">
                            {{ comment.content }}
                        </div>
                    </div>
                   {% endfor %}
                </div>
            </div>
        </div>

        <div class="food-right fl">
            <h2 class="food-title">{{ food.title }}</h2>
            <div class="food-sharer">
                <div class="sharer-img" style="background-image: url('/public/static/images/food2.jpg')"></div>
                <span class="sharer-name">{{ food.user }}</span>
                <span class="share-text">分享于</span>
                <span class="share-time">{{ food.created| date:"Y-m-d" }}</span>
            </div>
            <div class="food-item-title">
                简介
            </div>
            <p class="desc">
                {{ food.description }}
            </p>

                <div class="food-buy">
                    <a href="{{ food.link }}">
                        <i class="fa fa-link"></i>
                        来源链接
                    </a>
                </div>

            <div class="food-item-title">
                标签
            </div>
            <div class="tags">
                {% for tag in food.tags.all %}
                    <a href="{% url 'food:tag' tag=tag %}"><div class="tag-item">{{ tag }}</div></a>
                {% endfor %}
            </div>

            <div class="food-item-title">
                相似食物
            </div>
            <div class="similar-container clearfix">
                {% for food in similar_foods %}
                <div class="similar-item">
                    <a href="#"><img src="{{ MEDIA_URL }}{{ food.cover_image }}" alt="" width="100%" height="185px"></a>
                    <span class="similar-title">{{ food.title }}</span>
                </div>
                {% endfor %}
            </div>
        </div>
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/food_detail.js' %}"></script>
{% endblock js %}