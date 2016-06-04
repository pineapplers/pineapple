{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load thumbnail %}
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
            {% if request.user in topic.users_collect.all %}
            <button type="button" name="button" id="collect" data-id="{{ topic.id }}" data-action="uncollect">取消收藏</button>
            {% else %}
            <button type="button" name="button" id="collect" data-id="{{ topic.id }}" data-action="collect">收藏专题</button>
            {% endif %}
            <div class="topic-desc">
                {{ topic.description }}
            </div>
        </div>
    </div>
    {% for food in foods %}
    <div class="detail-item">
        <a href="#">
            {% thumbnail food.cover_image "1048x350" crop="center" as im %}
                <div class="detail-img-left" style="background-image: url('{{ im.url }}')"></div>
            {% endthumbnail %}
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
<script type="text/javascript">
    $(function() {
        $("#collect").click(function() {
            var that = $(this);
            var id = that.attr('data-id');
            var action = that.attr('data-action');

            $.ajax({
                url: "{% url 'topic:collect' %}",
                method: "POST",
                data: {
                    id: id,
                    action: action
                }
            }).success(function(resp) {
                if(resp.status == true) {
                    if (action == 'collect') {
                        that.attr('data-action', 'uncollect');
                        that.text('取消收藏');
                    } else {
                        that.attr('data-action', 'collect');
                        that.text('收藏专题');
                    }                     
                }
            }).error(function(error) {
                alert("网络异常");
            });
        });
    });
</script>
{% endblock js %}
