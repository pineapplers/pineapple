{% extends 'user/base.html' %}
{% load staticfiles %}
{% block head %}
<link href="{% static 'css/user_share.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="tab-container">
    <div class="share-container">
        <ul class="share-container-ul">
            <li class="share-container-item clearfix">
                <span class="share-time">分享于 6 小时前</span>
                <div class="item-index">
                    1.
                </div>
                <div class="images-item" style="background-image: url('/public/static/images/topic1.jpg')"></div>
                <div class="item-main">
                    <h3 class="item-title"><a href="#">「送男友」10款格调手机壳</a></h3>
                    <p class="item-desc">
                        给男友买百元以上手机壳的姑娘，都是真~爱~啊！毕竟对于一买就是三五个，
                        手机壳随着心情换的女生而言，廉价
                    </p>
                </div>
            </li>

            <li class="share-container-item">
                <span class="share-time">分享于 2 天前</span>
                <div class="item-index">
                    2.
                </div>
                <div class="images-item" style="background-image: url('/public/static/images/topic2.jpg')"></div>
                <div class="item-main">
                    <h3 class="item-title"><a href="#">家庭个护小能手，健康携手到白头</a></h3>
                    <p class="item-desc">
                        怀揣着对生活细节更高的要求，个人护理小家电已经成为了提高生活品质的一部分。现在市面上众多个性突出、功
                    </p>
                </div>
            </li>

            <li class="share-container-item">
                <span class="share-time">分享于 1 年前</span>
                <div class="item-index">
                    3.
                </div>
                <div class="images-item" style="background-image: url('/public/static/images/topic3.jpg')"></div>
                <div class="item-main">
                    <h3 class="item-title"><a href="#">Take Care Of Your Teeth</a></h3>
                    <p class="item-desc">
                        No matter what your age,you need to take care of your teeth and mouth.When your mouth is...
                    </p>
                </div>
            </li>
        </ul>
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_share.js' %}"></script>
{% endblock js %}
