{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% block head %}
<title>好吃</title>
<link href="{% static 'css/food_list.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="explore-container">
    <div class="explore-tab-container">
        <ul class="tab-ul clearfix">
            
            <li class="tab-ul-item current-item">最近热门</li>
            <li class="tab-ul-item">精选</li>
            <li class="tab-ul-item">零食</li>
            <li class="tab-ul-item">小吃</li>
            <li class="tab-ul-item">高档</li>
            <li class="tab-ul-item">发现</li>
        </ul>
    </div>

    <div class="explore-main-container clearfix">
        
        <div class="item">
            <a href="#">
                <div class="item-img" style="background-image: url('/public/static/images/food2.jpg')"></div>
            </a>
            <div class="item-main">
                <a href="#"><h3 class="item-title">苏格格巴登巴登小蛋糕</h3></a>
                <div class="item-tags">
                    <i class="fa fa-tags"></i>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                </div>
            </div>
        </div>

        
        <div class="item">
            <a href="#">
                <div class="item-img" style="background-image: url('/public/static/images/food2.jpg')"></div>
            </a>
            <div class="item-main">
                <a href="#"><h3 class="item-title">苏格格巴登巴登小蛋糕</h3></a>
                <div class="item-tags">
                    <i class="fa fa-tags"></i>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                </div>
            </div>
        </div>
        
        <div class="item">
            <a href="#">
                <div class="item-img" style="background-image: url('/public/static/images/food2.jpg')"></div>
            </a>
            <div class="item-main">
                <a href="#"><h3 class="item-title">苏格格巴登巴登小蛋糕</h3></a>
                <div class="item-tags">
                    <i class="fa fa-tags"></i>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                </div>
            </div>
        </div>
        
        <div class="item">
            <a href="#">
                <div class="item-img" style="background-image: url('/public/static/images/food2.jpg')"></div>
            </a>
            <div class="item-main">
                <a href="#"><h3 class="item-title">苏格格巴登巴登小蛋糕</h3></a>
                <div class="item-tags">
                    <i class="fa fa-tags"></i>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                </div>
            </div>
        </div>
        
        <div class="item">
            <a href="#">
                <div class="item-img" style="background-image: url('/public/static/images/food2.jpg')"></div>
            </a>
            <div class="item-main">
                <a href="#"><h3 class="item-title">苏格格巴登巴登小蛋糕</h3></a>
                <div class="item-tags">
                    <i class="fa fa-tags"></i>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                    <span class="tag"><a href="#">傻逼</a></span>
                </div>
            </div>
        </div>
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/food_list.js' %}"></script>
{% endblock js %}
