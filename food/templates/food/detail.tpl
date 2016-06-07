{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load widget_tweaks %}
{% load thumbnail %}
{% block head %}
<title>{{ food.title }}</title>
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
                            {% if is_wta %}
                            <div class="icon clicked" id="want" data-id="{{ food.id }}" data-action="unwta">
                                <a href="#"><i class="fa fa-cutlery">
                                    <span class="fa-margin">想吃</span>
                                </i></a>
                            </div>
                            {% else %}
                            <div class="icon" id="want" data-id="{{ food.id }}" data-action="wta">
                                <a href="#"><i class="fa fa-cutlery">
                                    <span class="fa-margin">想吃</span>
                                </i></a>
                            </div>
                            {% endif %}

                            {% if is_ate %}
                            <div class="icon clicked" id="ate" data-id="{{ food.id }}" data-action="unate">
                                <a href="#"><i class="fa fa-hand-peace-o">
                                    <span class="fa-margin">吃过</span>
                                </i></a>
                            </div>
                            {% else %}
                            <div class="icon" id="ate" data-id="{{ food.id }}" data-action="ate">
                                <a href="#"><i class="fa fa-hand-peace-o">
                                    <span class="fa-margin">吃过</span>
                                </i></a>
                            </div>
                            {% endif %}
                        </div>
                    </div>
                </div>

                <div class="food-like-share">
                    <div class="circle {% if score == 1 %}clicked{% endif %}" id="like" data-id="{{ food.id }}" data-action="like">
                        <i class="fa fa-thumbs-o-up"></i>
                        <span id="like-count">{{ food.rating.likes }}</span>
                    </div>
                    <div class="circle {% if score == -1 %}clicked{% endif %}" id="dislike" data-id="{{ food.id }}" data-action="dislike">
                        <i class="fa fa-thumbs-o-down"></i>
                        <span id="dislike-count">{{ food.rating.dislikes }}</span>
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
                <div class="comments-main">
                    {% if comments %}
                        {% for comment in comments %}
                        <div class="comments-item clearfix">
                            {% thumbnail comment.user.profile.avatar "50x50" crop="center" as im %}
                                <div class="comments-user-img" style="background-image: url('{{ im.url }}')"></div>
                            {% empty %}
                                <div class="comments-user-img" style="background-image: url('/public/static/images/anonymous.jpg')"></div>
                            {% endthumbnail %}
                            <div class="comments-user-name">
                                <span class="name"><a href="{{ comment.user.get_absolute_url }}">{{ comment.user }}</a></span>
                                <span class="comments-time">{{ comment.created| date:"Y/m/d H:m" }}</span>
                            </div>
                            <div class="comments-item-content">
                                {{ comment.content }}
                            </div>
                        </div>
                        {% endfor %}
                        {% if comments.has_previous %}
                        <a href="?page={{ comments.previous_page_number }}">
                        <button type="button" style="width: 200px;height: 50px;margin: 10px 30% 10px 30%;background-color: rgb(64,163,194);color: #fff;border: none;">上一页</button>
                        </a>
                        {% endif %}
                        {% if comments.has_next %}
                        <a href="?page={{ comments.next_page_number }}">
                        <button type="button" style="width: 200px;height: 50px;margin: 10px 30% 20px 30%;background-color: rgb(64,163,194);color: #fff;border: none;">下一页</button>
                        </a>
                        {% endif %}
                    {% else %}
                    <p>目前没有人评论</p>
                    {% endif %}
                </div>
            </div>
        </div>

        <div class="food-right fl">
            <h2 class="food-title">{{ food.title }}</h2>
            <div class="food-sharer">
                {% thumbnail food.user.profile.avatar "20x20" crop="center" as im %}
                    <div class="sharer-img" style="background-image: url('{{ im.url }}')"></div>
                {% empty %}
                    <div class="sharer-img" style="background-image: url('/public/static/images/anonymous.jpg')"></div>
                {% endthumbnail %}
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
    var hasLike = false;
    var hasDisLike = false;

    function clickLike() {
        if (hasLike && hasDisLike) {
            alert('你好无聊哦，不让你点了！');
            return
        }
        $("#like-count").text((parseInt($("#like-count").text()) + 1).toString());
        hasLike = true;
        if (hasDisLike) {
            $("#dislike-count").text((parseInt($("#dislike-count").text()) - 1).toString());
        }
    }

    function clickDisLike() {
        if (hasLike && hasDisLike) {
            alert('你好无聊哦，不让你点了！');
            return
        }
        hasDisLike = true;
        $("#dislike-count").text((parseInt($("#dislike-count").text()) + 1).toString());
        if (hasLike) {
            $("#like-count").text((parseInt($("#like-count").text()) - 1).toString());
        }
    }

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
        }).success(function(resp) {
            clickLike();
            that.addClass("clicked");
            $("#dislike").removeClass("clicked");
        }).error(function(error) {
            alert("网络异常");
        });
    });

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
        }).success(function(resp) {
            clickDisLike();
            that.addClass("clicked");
            $("#like").removeClass("clicked");
        }).error(function(error) {
            alert("网络异常");
        });
    });

    $("#want").click(function(event) {
        var that = $(this);
        var id = that.attr('data-id');
        var action = that.attr('data-action');

        $.ajax({
            url: "{% url 'food:wta' %}",
            method: "POST",
            data: {
                id: id,
                action: action
            }
        }).success(function(resp) {
            if (that.hasClass("clicked")) {
                that.removeClass("clicked");
            } else {
                that.addClass("clicked");
            }
        }).error(function(error) {
            alert("网络异常");
        });
    });

    $("#ate").click(function(event) {
        var that = $(this);
        var id = that.attr('data-id');
        var action = that.attr('data-action');

        $.ajax({
            url: "{% url 'food:ate' %}",
            method: "POST",
            data: {
                id: id,
                action: action
            }
        }).success(function(resp) {
            if (that.hasClass("clicked")) {
                that.removeClass("clicked");
            } else {
                that.addClass("clicked");
            }
        }).error(function(error) {
            alert("网络异常");
        });
    });


    $("#share").click(function(event) {
        event.preventDefault();
        var _width = 600,
            _height = 600,
            _top = (screen.height-_height)/2,
            _left = (screen.width-_width)/2,
            _pic = '';

        var _shareUrl = 'http://v.t.sina.com.cn/share/share.php?&appkey=895033136';
        _shareUrl += '&url='+ encodeURIComponent(document.location);
        _shareUrl += '&title=' + encodeURIComponent(document.title + ' - Pineapple');
        _shareUrl += '&source=' + encodeURIComponent('');
        _shareUrl += '&sourceUrl=' + encodeURIComponent('');
        _shareUrl += '&content=' + 'utf-8';
        _shareUrl += '&pic=' + encodeURIComponent('');
        window.open(_shareUrl,'_blank','width='+_width+',height='+_height+',top='+_top+',left='+_left+',toolbar=no,menubar=no,scrollbars=no, resizable=1,location=no,status=0');
    });
});
</script>
{% endblock js %}