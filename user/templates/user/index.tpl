{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% block head %}
<title>用户首页</title>
<link href="{% static 'css/user_index.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
    <div class="tab-container">
        <div class="timeline-container">
            <div class="timeline-item-main">
                
                <div class="timeline-item">
                    <i class="fa fa-share-alt"></i>
                    <span class="timeline-item-username">滨滨和泓泓</span>
                    <span class="timeline-item-action">分享了</span>
                    <span class="timeline-item-theme">《奥利奥油条新品》</span>
                    <span class="timeline-item-time">6小时前</span>
                </div>

                <div class="timeline-item">
                    <i class="fa fa-thumbs-up"></i>
                    <span class="timeline-item-username">滨滨和泓泓</span>
                    <span class="timeline-item-action">喜欢</span>
                    <span class="timeline-item-theme">《奥利奥油条新品》</span>
                    <span class="timeline-item-time">6小时前</span>
                </div>

                <div class="timeline-item">
                    <i class="fa fa-bookmark"></i>
                    <span class="timeline-item-username">滨滨和泓泓</span>
                    <span class="timeline-item-action">收藏了</span>
                    <span class="timeline-item-theme">《奥利奥油条新品》</span>
                    <span class="timeline-item-time">6小时前</span>
                </div>

                <div class="timeline-item">
                    <i class="fa fa-eye"></i>
                    <span class="timeline-item-username">tonnie</span>
                    <span class="timeline-item-action">关注了</span>
                    <span class="timeline-item-theme">你</span>
                    <span class="timeline-item-time">6小时前</span>
                </div>

                <div class="timeline-item">
                    <i class="fa fa-comment"></i>
                    <span class="timeline-item-username">滨滨和泓泓</span>
                    <span class="timeline-item-action">评论了</span>
                    <span class="timeline-item-theme">《奥利奥油条新品》</span>
                    <span class="timeline-item-time">6小时前</span>
                </div>

                <div class="timeline-item">
                    <i class="fa fa-cutlery"></i>
                    <span class="timeline-item-username">滨滨和泓泓</span>
                    <span class="timeline-item-action">想吃</span>
                    <span class="timeline-item-theme">《奥利奥油条新品》</span>
                    <span class="timeline-item-time">6小时前</span>
                </div>

                <div class="timeline-item">
                    <i class="fa fa-hand-peace-o"></i>
                    <span class="timeline-item-username">滨滨和泓泓</span>
                    <span class="timeline-item-action">吃过</span>
                    <span class="timeline-item-theme">《奥利奥油条新品》</span>
                    <span class="timeline-item-time">6小时前</span>
                </div>
            </div>

        </div>
    </div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_index.js' %}"></script>
{% endblock js %}