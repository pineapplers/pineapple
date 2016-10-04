{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load widget_tweaks %}
{% block head %}
<title>讨论区</title>
<link href="{% static 'css/forum_list.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="list-container">
    <form method="post" action=".">
        <label class="form-label">标题</label>
        {{ form.title.errors }}
        <div class="item-input">
            {{ form.title | add_class:"input" | attr:"placeholder:请输入标题"}}
        </div>

        <label class="form-label">内容</label>
        {{ form.content.errors }}
        <div class="item-input">
            {{ form.content | add_class:"input" | attr:"placeholder:请输入内容"}}
        </div>
        <button type="submit">发表</button>
    </form>
</div>
{% endblock content %}
{% block js %}
{% endblock js %}