{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load widget_tweaks %}
{% load thumbnail %}
{% block head %}
<title>{{ post.title }}</title>
<link href="{% static 'css/forum_detail.css' %}" rel="stylesheet">
<link href="http://cdn.bootcss.com/wangeditor/2.1.10/css/wangEditor.min.css" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="list-container">
    <div class="post-bar">
        <div class="post-header">
            <div class="post-title">{{ post.title }}
                <a href="#reply"><button id="reply-btn">回复</button></a>
            </div>
        </div>
        <table>
            <tr class="body">
                <td class="user">
                    {% thumbnail post.creator.profile.avatar "100x100" crop="center" as im %}
                        <img class="avatar" src="{{ im.url }}" alt="商品图片" width="100%" height="100%">
                    {% empty %}
                        <img class="avatar" src="/public/static/images/anonymous.jpg"/>
                    {% endthumbnail %}
                    <a class="username" href="{{ post.creator.get_absolute_url }}">{{ post.creator }}</a>
                </td>
                <td class="content">{{ post.content|safe }}</td>
            </tr>
            {% for comment in post.comments.all %}
            <tr class="body">
                <td class="user">
                    {% thumbnail comment.user.profile.avatar "100x100" crop="center" as im %}
                        <img class="avatar" src="{{ im.url }}" alt="商品图片" width="100%" height="100%">
                    {% empty %}
                        <img class="avatar" src="/public/static/images/anonymous.jpg"/>
                    {% endthumbnail %}
                    <a class="username" href="{{ comment.user.get_absolute_url }}">{{ comment.user }}</a>
                </td>
                <td class="content">{{ comment.content|safe }}</td>
            </tr>
            {% endfor %}
        </table>
    </div>
    <form method="post" action=".">
        {% csrf_token %}
        <div style="margin:10px;"></div>
        {{ form.content.errors }}
        <div class="item-input" id="reply">
            {{ form.content | add_class:"comment-content" | attr:"placeholder:请输入内容"}}
        </div>
        <button type="submit" class="comment-submit" style="margin:10px;">评论</button>
    </form>
</div>
{% endblock content %}
{% block js %}
<script src="http://cdn.bootcss.com/wangeditor/2.1.10/js/wangEditor.min.js"></script>
<script type="text/javascript">
$(function () {
    var editor = new wangEditor('id_content');
    editor.create();
});
</script>
{% endblock js %}