{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% block head %}
<title>首页</title>
<link href="{% static 'css/home_index.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="container">
    <div class="container-top">
        <div class="desc">
            <div class="desc-main">
                <div class="desc-main-title">
                    Pineapple
                </div>
                发现好吃的，好玩的
            </div>
        </div>
        <div class="pineapple-logo">
            Pineapple
        </div>
    </div>
</div>

<div class="topic-container">
    <div class="topic-container-title">
        <h1><span class="title-hr"></span>精选专题<span class="title-hr"></span></h1>
    </div>
    <div class="topic-container-main">
        <div class="topic-item">
            
            <a href="#"><div class="topic-item-img" style="background-image: url('/public/static/images/topic1.jpg')"></div></a>
            <div class="topic-item-desc">
                <a href="#"><h3 class="desc-title">「送男友」10款格调手机壳</h3></a>
                <a href="#"><h4 class="desc-content">给男友买百元以上手机壳的姑娘，都是真~爱~啊！毕竟对于一买就是三五个，手机壳随着心情换的女生而言，廉价...</h4></a>
            </div>
            <div class="topic-item-info">
                
                <i class="fa fa-heart"><span class="num">153</span></i>
                <i class="fa fa-comments"><span class="num">97</span></i>
                <a href="#"><a href="#"><i class="fa fa-share-alt"></i></a></a>
            </div>
        </div>
        <div class="topic-item">
            
            <a href="#"><div class="topic-item-img" style="background-image: url('/public/static/images/topic2.jpg')"></div></a>
            <div class="topic-item-desc">
                <a href="#"><h3 class="desc-title">家庭个护小能手，健康携手到白头</h3></a>
                <a href="#"><h4 class="desc-content">怀揣着对生活细节更高的要求，个人护理小家电已经成为了提高生活品质的一部分。现在市面上众多个性突出、功...</h4></a>
            </div>
            <div class="topic-item-info">
                <i class="fa fa-heart"><span class="num">153</span></i>
                <i class="fa fa-comments"><span class="num">97</span></i>
                <a href="#"><i class="fa fa-share-alt"></i></a>
            </div>
        </div>
        <div class="topic-item">
            
            <a href="#"><div class="topic-item-img" style="background-image: url('/public/static/images/topic3.jpg')"></div></a>
            <div class="topic-item-desc">
                <a href="#"><h3 class="desc-title">Take Care Of Your Teeth</h3></a>
                <a href="#"><h4 class="desc-content">No matter what your age,you need to take care of your teeth and mouth.When your mouth is...</h4></a>
            </div>
            <div class="topic-item-info">
                <i class="fa fa-heart"><span class="num">153</span></i>
                <i class="fa fa-comments"><span class="num">97</span></i>
                <a href="#"><i class="fa fa-share-alt"></i></a>
            </div>
        </div>
        <div class="topic-item">
            
            <a href="#"><div class="topic-item-img" style="background-image: url('/public/static/images/topic4.jpg')"></div></a>
            <div class="topic-item-desc">
                <a href="#"><h3 class="desc-title">Take Care Of Your Teeth</h3></a>
                <a href="#"><h4 class="desc-content">No matter what your age,you need to take care of your teeth and mouth.When your mouth is...</h4></a>
            </div>
            <div class="topic-item-info">
                <i class="fa fa-heart"><span class="num">153</span></i>
                <i class="fa fa-comments"><span class="num">97</span></i>
                <a href="#"><i class="fa fa-share-alt"></i></a>
            </div>
        </div>
        <div class="topic-item">
            
            <a href="#"><div class="topic-item-img" style="background-image: url('/public/static/images/topic5.jpg')"></div></a>
            <div class="topic-item-desc">
                <a href="#"><h3 class="desc-title">Take Care Of Your Teeth</h3></a>
                <a href="#"><h4 class="desc-content">No matter what your age,you need to take care of your teeth and mouth.When your mouth is...</h4></a>
            </div>
            <div class="topic-item-info">
                <i class="fa fa-heart"><span class="num">153</span></i>
                <i class="fa fa-comments"><span class="num">97</span></i>
                <a href="#"><i class="fa fa-share-alt"></i></a>
            </div>
        </div>
        <div class="topic-item">
            
            <a href="#"><div class="topic-item-img" style="background-image: url('/public/static/images/topic6.jpg')"></div></a>
            <div class="topic-item-desc">
                <a href="#"><h3 class="desc-title">Take Care Of Your Teeth</h3></a>
                <a href="#"><h4 class="desc-content">No matter what your age,you need to take care of your teeth and mouth.When your mouth is...</h4></a>
            </div>
            <div class="topic-item-info">
                <i class="fa fa-heart"><span class="num">153</span></i>
                <i class="fa fa-comments"><span class="num">97</span></i>
                <a href="#"><i class="fa fa-share-alt"></i></a>
            </div>
        </div>
        <div class="topic-item">
            
            <a href="#"><div class="topic-item-img" style="background-image: url('/public/static/images/topic7.jpg')"></div></a>
            <div class="topic-item-desc">
                <a href="#"><h3 class="desc-title">Take Care Of Your Teeth</h3></a>
                <a href="#"><h4 class="desc-content">No matter what your age,you need to take care of your teeth and mouth.When your mouth is...</h4></a>
            </div>
            <div class="topic-item-info">
                <i class="fa fa-heart"><span class="num">153</span></i>
                <i class="fa fa-comments"><span class="num">97</span></i>
                <a href="#"><i class="fa fa-share-alt"></i></a>
            </div>
        </div>
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/home_index.js' %}"></script>
{% endblock js %}
