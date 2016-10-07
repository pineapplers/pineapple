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
                <a href="?order=all">综合排序</a> |
                <a href="?order=time">时间排序</a>
            </div>
        </div>
        {% for post in posts %}
        <div class="post">
            <table>
                <tr>
                    <td class="rating"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAABVlBMVEUAAAAOuJsAqY0NuJoQtJxEREAPs5UUq4xEREARu5kMtpoSq5EQsJVEREAMspREREAYoogQsZQOsJMNt5gNtZpEREAVookSrJEQsZMLuJoNtpoMt5kPt5dEREBEREBEREAUp4wTtZQ0tog5s4Y6tIUAqqpEREB1Wj3wozz2qTv1pzv1pzn3qDv1oz/QhDb0pzn2pzv2qTr4qTb3pTT3qDv1pjvnoDvupD31pzv4qTv4qTn2qTv3qTr0pTfinjvpoDu8hz7+rTn3qTn2qTnqojvfnD3uoDn2qTv0pjn2qTr3pzz4rTr4qTn0qDvroTnyqDr4qDn3pzv2qDz1qDvhnTvalzrbmT70pzr1pzn1qDnzqDvnoTvUlD3mnjv1pzvzrDz3pzn1qTvqojrvpTv1qTv3qDrOlTr2qTn3qTn3qTn3qDvvrz8Nt5n3qTv2qDvupDvsozv2qTvZwaGBAAAAbHRSTlMAJAleHwFXKQQPy1XBCRoCRPf1vyYBTZfkxr6hIAUND1zhyMd+AwoSJ7X+/KscB5TwfioigfCVIttvS7CvSnjdKRZi0M5kFFbzV0NObtzgclBAO9NtWltp1TW+o06KhUSguYv6+oIWhsjHhBAHDtvAAAAAr0lEQVQYGQXBu0rEQABA0Xszj0wECSpTSLSxjOAH7b+Jn2SljaBgsU1k2XUKA8uq5wAAIAAg0Knq6QggwKDqN0CKAFlVgNo6YOz7fpPzdMO4VqEOqurbOJZPSeWyqKp7d2skXK9FVfWvNLndz6qqPh+ILOdnOqMveoCO05J3M+p9CEDkSJg+vPPdIhCBMm3dOli/IAmwUVWfqC0A9fUhXuTf8EhdryKkVqM/ZkmtLv96OCeBHzvVWAAAAABJRU5ErkJggg=="> x {{ post.total_likes }}</td>
                    <td class="board"><a href="">[{{ post.board | default:"主版块" }}]</a></td>
                    <td class="title"><a href="{{ post.get_absolute_url }}">{{ post.title }}</a></td>
                    <td class="creator"><a href="{{ post.creator.get_absolute_url }}"><b>{{ post.creator }}</b></a></td>
                </tr>
            </table>
        </div>
        {% endfor %}
        {% if posts.has_other_pages %}
            <div class="page">
                {% if posts.has_next %}
                <a class="switch-page" href="?page=999999">尾页</a>
                <a class="switch-page" href="?page={{ posts.next_page_number }}">下一页</a>
                {% endif %}
                {% if posts.has_previous %}
                <a class="switch-page" href="?page={{ posts.previous_page_number }}">上一页</a>
                {% endif %}
                <div class="clearfix"></div>
            </div>
        {% endif %}
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