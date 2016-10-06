{% load widget_tweaks %}
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
            <li>
                <a href="{% url 'forum:index' %}">讨论区</a>
                <span class="cursor"></span>
            </li>
        </ul>
        {% if request.user.is_authenticated %}
            <a href="{% url 'food:create' %}"><button type="button">分享</button></a>
            <div class="user-name">
                <button type="button" name="user-name-btn" class="user-name-btn">{{ request.user.username }}
                    <span class="redpoint" style="display: none;"></span>
                </button>
                <ul class="user-dropdown">
                    <a href="{% url 'user:home' user_id=request.user.id %}"><li>资料</li></a>
                    <a id="message">
                        <li>私信 (<span id="msg-count">0</span>)</li>
                    </a>
                </ul>
            </div>
        {% else %}
            <a href="{% url 'user:login' %}"><button type="button" name="login" id="login-btn">登录</button></a>
            <a href="{% url 'user:register' %}"><button type="button" name="register" id="register-btn">注册</button></a>
        {% endif %}
        <form method="post" action="{% url 'search:search' %}">
            {% csrf_token %}
            {{ search_form.q | attr:"id:search" | attr:"placeholder:寻觅好吃……"}}
        </form>
    </div>
</div>