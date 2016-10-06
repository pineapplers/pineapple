{% load staticfiles %}
{% load widget_tweaks %}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>注册 - Pineapple</title>
        <style media="screen">
            .user-container {
                margin-top: -250px !important;
            }
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
        <link href="{% static 'css/vendors.css' %}" rel="stylesheet">
        <link href="{% static 'css/user_register.css' %}" rel="stylesheet">
    </head>
    <body>
        {% include 'home/navbar.tpl' %}
        <div id="particles-js"></div>
        <div class="user-container">
            <div class="user-container-title">
                <h2>注册</h2>
                <h3>注册，打开一个新的世界</h3>
            </div>
            <div class="form-container" id="form-container">
                {% for err, desc in form.errors.items %}
                    {{ desc }}
                {% endfor %}
                <form class="" action="." method="post" autocomplete="off">
                    {% csrf_token %}
                    <div class="form-item">
                        <label for="username">用户名</label>
                        {{ form.username | attr:"required:required" }}
                    </div>
                    <div class="form-item">
                        <label for="email">邮箱</label>
                        {{ form.email | attr:"required:required" }}
                    </div>
                    <div class="form-item">
                        <label for="password">密码</label>
                        {{ form.password | attr:"required:required" }}
                    </div>
                    <div class="form-item">
                        <label for="confirmPassword">确认密码</label>
                        {{ form.confirm_password | attr:"required:required" }}
                    </div>

                    <div class="form-item">
                        <input type="submit" name="register" id="register-btn" value="注册">
                    </div>
                    <div class="register-tab">
                        <a href="{% url 'user:login' %}">已有账号？点击登录</a>
                    </div>
                </form>
            </div>
        </div>
        <script src="{% static 'js/vendors.js' %}"></script>
        <script src="http://cdn.staticfile.org/particles.js/2.0.0/particles.min.js"></script>
        <script src="{% static 'js/user_register.js' %}"></script>
        <script type="text/javascript">
            particlesJS.load("particles-js", "/public/static/assets/particles.json", function() {
              console.log('callback - particles.js config loaded');
            });
        </script>
    </body>
</html>
