{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% block head %}
<title>分享</title>
<link href="{% static 'css/food_create.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="create-container">
    <div class="title">
        分享 | Share
    </div>

    <form class="create-form" action="index.html" method="post">
        <div class="form-item">
            <label class="form-label">Yummy 图片</label>
            <div class="preview-main clearfix">
                <div class="preview-img" id="preview-img" style="background-image: url('/public/static/images/topic1.jpg')"></div>
                <label for="upload" class="upload">
                    + 上传图片
                </label>
                <input type="file" name="upload" value="upload" id="upload">
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-title">标题</label>
            <div class="item-input">
                <input type="text" name="title" class="input" id="create-title" placeholder="请输入名称">
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-type">分类</label>
            <div class="selections">
                <select class="types" name="type">
                    <option value="默认">默认</option>
                    <option value="好吃">好吃</option>
                    <option value="高脂">高脂</option>
                </select>
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-tag">标签</label>
            <div class="item-input">
                <input type="text" name="tag" class="input" id="create-tag" placeholder="请输入标签">
                <div class="add-tag" id="add-tag">
                    +
                </div>
                <div class="tag-preview" id="tag-preview">
                    
                </div>
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-link">来源链接</label>
            <div class="item-input">
                <input type="url" name="link" class="input" id="create-link" placeholder="http://xxx.com/xxx">
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-desc">简介</label>
            <div class="item-input">
                <textarea name="desc" rows="8" cols="40" id="desc" class="textarea"></textarea>
            </div>
        </div>
    </form>

</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/food_create.js' %}"></script>
{% endblock js %}