{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load widget_tweaks %}
{% load thumbnail %}
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
                    {% thumbnail food.cover_image "490x367" crop="center" as im %}
                        <img src="{{ im.url }}" alt="商品图片" width="100%" height="100%">
                    {% endthumbnail %}
                    <div class="food-img-shadow">
                        <div class="shadow-icons">
                            <div class="icon {% if is_wta %}clicked{% endif %}" id="want" data-id="{{ food.id }}">
                                <a href="#">
                                    <i class="fa fa-cutlery">
                                        <span class="fa-margin">想吃</span>
                                    </i>
                                </a>
                            </div>

                            <div class="icon {% if is_ate %}clicked{% endif %}" id="ate" data-id="{{ food.id }}">
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
                    <div class="circle" id="like" data-id="{{ food.id }}" data-action="like">
                        <i class="fa fa-thumbs-o-up"></i>
                        <span>{{ food.rating.likes }}</span>
                    </div>
                    <div class="circle" id="dislike" data-id="{{ food.id }}" data-action="dislike">
                        <i class="fa fa-thumbs-o-down"></i>
                        <span>{{ food.rating.dislikes }}</span>
                    </div>
                    <div class="circle" id="share">
                        <i class="fa fa-share-alt"></i>
                    </div>
                </div>
            </div>

            <div class="comments-container">
                <div class="comments-wraaper clearfix">
                    <form method="post" action=".">
                        {% csrf_token %}
                        {{ comment_form.content | add_class:"comments-area" | attr:"rows:5"}}
                        <button type="submit" name="sendBtn" class="send-btn">发表评论</button>
                    </form>
                </div>
                <h2 class="comments-title">全部评论</h2>
                {% with comments=comments %}
                <div class="comments-main">
                    {% if comments %}
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
                    {% else %}
                    <p>目前没有人评论</p>
                    {% endif %}
                </div>
                {% endwith %}
            </div>
        </div>

        <div class="food-right fl">
            <h2 class="food-title">{{ food.title }}</h2>
            <div class="food-sharer">
                <div class="sharer-img" style="background-image: url('/public/static/images/food2.jpg')"></div>
                <a href="{{ food.user.get_absolute_url }}"><span class="sharer-name">{{ food.user }}</span></a>
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
                {% with tags=food.tags.all %}
                    {% if tags %}
                        {% for tag in tags %}
                            <a href="{% url 'food:tag' tag=tag %}"><div class="tag-item">{{ tag }}</div></a>
                        {% endfor %}
                    {% else %}
                        <p>该食物没有添加标签😊</p>
                    {% endif %}
                {% endwith %}
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
<script type="text/javascript">
$(function() {

    // 喜欢
    $("#like").click(function(event) {
        var that = $(this);
        var id = that.attr('data-id');
        var action = that.attr('data-action');

        $.ajax({
            url: "{% url 'food:rate' %}",
            method: "POST",
            data: {
                id: id,
                action: action
            }
        }).success(function(data) {
            self.className = "circle liked";
            dislikeDom.className = "circle";
            shareDom.className = "circle";
        }).error(function(error) {
            alert("网络异常");
        });
    });

    // 不喜欢
    $("#dislike").click(function(event) {
        var that = $(this);
        var id = that.attr('data-id');
        var action = that.attr('data-action');

        $.ajax({
            url: "{% url 'food:rate' %}",
            method: "POST",
            data: {
                id: id,
                action: action
            }
        }).success(function(data) {
            self.className = "circle liked";
            likeDom.className = "circle";
            shareDom.className = "circle";
        }).error(function(error) {
            alert("网络异常");
        });
    });

    $("#want").click(function(event) {
        var that = $(this);
        var id = that.attr('data-id');

        $.ajax({
            url: "{% url 'food:wta' %}",
            method: "POST",
            data: {
                id: id
            }
        }).success(function(data) {
            that.addClass("clicked");
            // self.className = "icon clicked";
        }).error(function(error) {
            alert("网络异常");
        });
    });

    $("#ate").click(function(event) {
        var that = $(this);
        var id = that.attr('data-id');

        $.ajax({
            url: "{% url 'food:ate' %}",
            method: "POST",
            data: {
                id: id
            }
        }).success(function(data) {
            that.addClass("clicked");
        }).error(function(error) {
            alert("网络异常");
        });
    });
});
</script>
{% endblock js %}