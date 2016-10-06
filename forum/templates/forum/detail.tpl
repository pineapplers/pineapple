{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load widget_tweaks %}
{% load thumbnail %}
{% block head %}
<title>{{ post.title }}</title>
<link href="{% static 'css/forum_detail.css' %}" rel="stylesheet">
<link href="{% static 'css/wangEditor.css' %}" rel="stylesheet">
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
                <td valign="top" class="user">
                    {% thumbnail post.creator.profile.avatar "100x100" crop="center" as im %}
                        <img class="avatar" src="{{ im.url }}" alt="商品图片" width="100%" height="100%">
                    {% empty %}
                        <img class="avatar" src="/public/static/images/anonymous.jpg"/>
                    {% endthumbnail %}
                    <a class="username" href="{{ post.creator.get_absolute_url }}">{{ post.creator }}</a>
                </td>
                <td valign="top" class="content">{{ post.content|safe }}</td>
                <td valign="bottom" class="info">
                    <p class="info-detail">
                        <a id="post-like" href="#">🍍 推荐</a>
                    </p>
                    <p>{{ post.created }}</p>
                </td>
            </tr>
            {% for comment in comments %}
            <tr class="body">
                <td valign="top" class="user">
                    {% thumbnail comment.user.profile.avatar "100x100" crop="center" as im %}
                        <img class="avatar" src="{{ im.url }}" alt="商品图片" width="100%" height="100%">
                    {% empty %}
                        <img class="avatar" src="/public/static/images/anonymous.jpg"/>
                    {% endthumbnail %}
                    <a class="username" href="{{ comment.user.get_absolute_url }}">{{ comment.user }}</a>
                </td>
                <td valign="top" class="content">{{ comment.content|safe }}</td>
                <td valign="bottom" class="info">
                    <p class="info-detail"><a href="#reply">引用</a></p>
                    <p>{{ comment.created }}</p>
                </td>
            </tr>
            {% endfor %}
        </table>
            {% if comments.has_other_pages %}
                <div class="page">
                    {% if comments.has_next %}
                    <a class="switch-page" href="?page=999999">尾页</a>
                    <a class="switch-page" href="?page={{ comments.next_page_number }}">下一页</a>
                    {% endif %}
                    {% if comments.has_previous %}
                    <a class="switch-page" href="?page={{ comments.previous_page_number }}">上一页</a>
                    {% endif %}
                    <div class="clearfix"></div>
                </div>
            {% endif %}
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

    $("#post-like").click(function(){
        $.ajax({
            url: "{% url 'forum:like' post_id=post.id %}",
            type: "GET"
        }).success(function(resp) {
            if (resp.status != true) {
                alert(resp.reason);
            }
        }).error(function() {
            alert('网络错误');
        });
    });

    $(".reply").click(function(){
        var content = $(this).parent().prev('.content').html();
        editor.$txt.append("<blockquote>" + content +"</blockquote>");
    });
});
</script>
{% endblock js %}