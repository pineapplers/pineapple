{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load widget_tweaks %}
{% block head %}
<title>讨论区</title>
<link href="{% static 'css/forum_list.css' %}" rel="stylesheet">
<link href="{% static 'css/wangEditor.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="list-container">
    <div class="post-bar">
        <div class="post-boards">
            <form action="{% url 'forum:query' %}" method="post">
                <div class="post-board">主版块
                    {% csrf_token %}
                    <input type="" name="q" class="post-search" placeholder="帖子标题..">
                    <button class="post-search-btn" type="submit">搜索</button>
                </div>
            </form>
            <div class="post-order">
                <a href="">综合排序</a> |
                <a href="" class="active">时间排序</a>
            </div>
        </div>
        {% for post in posts %}
        <div class="post">
            <table>
                <tr>
                    <td class="rating">🍍 x {{ post.total_likes }}</td>
                    <td class="board"><a href="">[{{ post.board | default:"主版块" }}]</a></td>
                    <td class="title"><a href="{{ post.get_absolute_url }}">{{ post.title }}</a></td>
                    <td class="creator"><a href="{{ post.creator.get_absolute_url }}"><b>{{ post.creator }}</b></a></td>
                </tr>
            </table>
        </div>
        {% endfor %}
    </div>
    <form method="post" action=".">
        {% csrf_token %}
        {{ form.title.errors }}
        <div class="item-input">
            {{ form.title | add_class:"post-title" | attr:"placeholder:请输入标题"}}
        </div>

        <div style="margin:10px;"></div>
        {{ form.content.errors }}
        <div class="item-input">
            {{ form.content | add_class:"post-content" | attr:"placeholder:请输入内容"}}
        </div>
        <button type="submit" class="post-submit">发表</button>
    </form>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/wangEditor.js' %}"></script>
<script type="text/javascript">
$(function () {
    var editor = new wangEditor('id_content');
    editor.config.menus = [
        'bold',
        'underline',
        'italic',
        'strikethrough',
        'eraser',
        'forecolor',
        '|',
        'quote',
        'fontsize',
        'head',
        'unorderlist',
        'orderlist',
        'alignleft',
        'aligncenter',
        'alignright',
        '|',
        'link',
        'unlink',
        'table',
        '|',
        'img',
        'video',
        'insertcode',
        '|',
        'fullscreen'
    ];
    editor.create();
});
</script>
{% endblock js %}