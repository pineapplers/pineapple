{% load staticfiles %}
{% load widget_tweaks %}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>登录 - Pineapple</title>
        <link href="{% static 'css/vendors.css' %}" rel="stylesheet">
        <link href="{% static 'css/user_login.css' %}" rel="stylesheet">
        <style type="text/css">
            #particles-js {
              position: absolute;
              width: 100%;
              height: 100%;
              background-color: rgb(247, 250, 252);
              background-image: url("");
              background-repeat: no-repeat;
              background-size: cover;
              background-position: 50% 50%;
              z-index: -1;
            }
        </style>
    </head>
    <body>
        {% include 'home/navbar.tpl' %}
        <div id="particles-js"></div>
        <div class="user-container">
            <div class="user-container-title">
                <h2>登录</h2>
                <h3>登录，寻找更好的</h3>
            </div>
            <div class="form-container" id="form-container">
                {% for err, desc in form.errors.items %}
                    {{ desc }}
                {% endfor %}
                <form class="" action="" method="post" autocomplete="off">
                    {% csrf_token %}
                    <div class="form-item">
                        <label for="username">用户名或邮箱</label>
                        {{ form.username | attr:"required:required" }}
                    </div>
                    <div class="form-item">
                        <label for="password">密码</label>
                        {{ form.password | attr:"required:required"}}
                    </div>
                    <div class="form-item">
                        <input type="submit" name="login" id="login-btn" value="登录">
                    </div>
                    <div class="register-tab">
                        <a href="{% url 'user:register' %}">还没有帐号？点此注册</a>
                    </div>
                </form>
            </div>
        </div>
    <script src="{% static 'js/vendors.js' %}"></script>
    <script src="http://cdn.bootcss.com/particles.js/2.0.0/particles.min.js"></script>
    <script src="{% static 'js/user_login.js' %}"></script>
    <script type="text/javascript">
        particlesJS.load("particles-js", "/public/static/assets/particles.json", function() {
          console.log('callback - particles.js config loaded');
        });
    </script>
    </body>
</html>
