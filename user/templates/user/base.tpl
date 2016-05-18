{% load staticfiles %}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="{% static 'font/font-awesome-4.5.0/css/font-awesome.min.css' %}" media="screen" title="no title" charset="utf-8">
        <link href="{% static 'css/vendors.css' %}" rel="stylesheet">
        <title>{{ user.username }}的主页</title>
        {% block head %}
        {% endblock head %}
        </head>
    <body>
        {% include 'home/navbar.tpl' %}
        <div class="user-container clearfix">
            <div class="user-main clearfix">
                <div class="user-portrait">
                    
                    <a href="#"><button type="button" name="button" class="follow-btn unfollow">关注</button></a>
                </div>
                <div class="user-info">
                    <h2 class="user-name"><i class="fa fa-venus"></i>{{ user.username }}</h2>
                    <h4 class="user-area">{{ profile.city  }}</h4>
                    <h4 class="user-desc">{{ profile.introduction }}</h4>
                </div>
                <div class="user-follower">
                    <div class="follow-num">{{ followers_num }}</div>
                    粉丝
                </div>
                <div class="user-following">
                    <div class="follow-num">{{ following_num }}</div>
                    关注
                </div>
            </div>

            <div class="user-tabs clearfix">
                <a href="{% url 'user:home' user.id %}">
                    <div class="tab-item current-tab">
                        主页
                    </div>
                </a>
                <a href="{% url 'user:share' user.id %}">
                    <div class="tab-item">
                        分享
                    </div>
                </a>
                <a href="{% url 'user:topic-collection' user.id %}">
                    <div class="tab-item">
                        专题收藏
                    </div>
                </a>
                <a href="{% url 'user:ate' user.id %}">
                    <div class="tab-item">
                        吃过的
                    </div>
                </a>
                <a href="{% url 'user:wta' user.id %}">
                    <div class="tab-item">
                        想吃的
                    </div>
                </a>
                <a href="{% url 'user:following' user.id %}">
                    <div class="tab-item">
                        关注
                    </div>
                </a>
                <a href="{% url 'user:followers' user.id %}">
                    <div class="tab-item">
                        粉丝
                    </div>
                </a>
                {% if request.user.id == user.id %}
                <a href="{% url 'user:settings' %}">
                    <div class="tab-item">
                        设置
                    </div>
                </a>
                {% endif %}
            </div>
            {% block content %}
            {% endblock content %}
        </div>
    <script src="{% static 'js/vendors.js' %}"></script>
    <script src="{% static 'js/user_base.js' %}"></script>
    {% block js %}
    {% endblock js %}
</body>
</html>