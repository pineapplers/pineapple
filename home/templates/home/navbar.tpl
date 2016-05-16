<div class="navbar">
    <div class="nav">
        <ul>
            <li>
                <a href="#">首页</a>
                <span class="cursor"></span>
            </li>
            <li>
                <a href="#">专题</a>
                <span class="cursor"></span>
            </li>
            <li>
                <a href="#">发现</a>
                <span class="cursor"></span>
            </li>
            <li>
                <a href="#">吃</a>
                <span class="cursor"></span>
            </li>
            <li>
                <a href="#">旅</a>
                <span class="cursor"></span>
            </li>
        </ul>
        {% if request.user.is_authenticated %}
            <a href="{% url 'user:home' request.user.id %}">{{ request.user.username }}</a>
        {% else %}
            <a href="{% url 'user:login' %}"><button type="button" name="login" id="login-btn">登录</button></a>
            <a href="{% url 'user:register' %}"><button type="button" name="register" id="register-btn">注册</button></a>
        {% endif %}
        <input type="text" name="search" value="寻找好物……" id="search">
    </div>
</div>