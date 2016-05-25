<div class="navbar">
    <div class="nav">
        <ul>
            <li>
                <a href="{% url 'home:index' %}">首页</a>
                <span class="cursor"></span>
            </li>
            <li>
                <a href="{% url 'topic:list' %}">专题</a>
                <span class="cursor"></span>
            </li>
            <li>
                <a href="{% url 'food:explore' %}">发现</a>
                <span class="cursor"></span>
            </li>
            <li>
                <a href="{% url 'food:list' %}">好吃</a>
                <span class="cursor"></span>
            </li>
        </ul>
        {% if request.user.is_authenticated %}
            <a href="{% url 'user:home' user_id=request.user.id %}"><button>{{ request.user.username }}</button></a>
        {% else %}
            <a href="{% url 'user:login' %}"><button type="button" name="login" id="login-btn">登录</button></a>
            <a href="{% url 'user:register' %}"><button type="button" name="register" id="register-btn">注册</button></a>
        {% endif %}
        <input type="text" name="search" value="寻找好物……" id="search">
    </div>
</div>