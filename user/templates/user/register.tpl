{% load staticfiles %}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>注册</title>
        <style media="screen">
            .user-container {
                margin-top: -250px !important;
            }
        </style>
        <link href="{% static 'css/vendors.css' %}" rel="stylesheet">
        <link href="{% static 'css/user_register.css' %}" rel="stylesheet">
    </head>
    <body>
        <div class="user-container">
            <div class="user-container-title">
                <h2>注册</h2>
                <h3>注册，加入我们的大家庭</h3>
            </div>
            <div class="form-container" id="form-container">
                <form class="" action="." method="post" autocomplete="off">
                    {% csrf_token %}
                    <div class="form-item">
                        <label for="username">账号 | USERNAME</label>
                        {{ form.username }}
                    </div>
                    <div class="form-item">
                        <label for="email">邮箱 | EMAIL</label>
                        {{ form.email }}
                    </div>
                    <div class="form-item">
                        <label for="password">密码 | PASSWORD</label>
                        {{ form.password }}
                    </div>
                    <div class="form-item">
                        <label for="confirmPassword">确认密码 | CONFIRM</label>
                        {{ form.confirm_password }}
                    </div>

                    <div class="form-item">
                        <input type="submit" name="register" id="register-btn" value="注册">
                    </div>
                    <div class="register-tab">
                        <a href="{% url 'user:login' %}">已有账号 | GO TO LOGIN</a>
                    </div>
                </form>
            </div>
        </div>
        <script src="{% static 'js/vendors.js' %}"></script>
        <script src="{% static 'js/user_register.js' %}"></script>
    </body>
</html>
