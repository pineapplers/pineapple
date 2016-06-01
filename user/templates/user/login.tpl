{% load staticfiles %}
{% load widget_tweaks %}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>登录</title>
        <link href="{% static 'css/vendors.css' %}" rel="stylesheet">
        <link href="{% static 'css/user_login.css' %}" rel="stylesheet">
        <style type="text/css">
            img {
                position: fixed;
                right: 0;
                bottom: 0;
                min-width: 100%;
                min-height: 100%;
                width: auto;
                height: auto;
                z-index: -9999;
                -webkit-filter: gray;
            }
        </style>
    </head>
    <body>
        <img src="/public/static/images/bg.jpg">
        <div class="user-container">
            <div class="user-container-title">
                <h2>登录</h2>
                <h3>登录，寻找更好的</h3>
            </div>
            <div class="form-container" id="form-container">
                <form class="" action="" method="post" autocomplete="off">
                    {% csrf_token %}
                    <div class="form-item">
                        <label for="email">账号 | USERNAME</label>
                        {{ form.username }}
                    </div>
                    <div class="form-item">
                        <label for="password">密码 | PASSWORD</label>
                        {{ form.password }}
                    </div>
                    <div class="form-item">
                        <input type="submit" name="login" id="login-btn" value="登录">
                    </div>
                    <div class="register-tab">
                        <a href="{% url 'user:register' %}">加入我们 | JOIN US</a>
                    </div>
                </form>
            </div>
        </div>
    <script src="{% static 'js/vendors.js' %}"></script>
    <script src="{% static 'js/user_login.js' %}"></script>
    </body>
</html>
