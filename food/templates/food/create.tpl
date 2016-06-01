{% extends 'home/base.tpl' %}
{% load staticfiles %}
{% load widget_tweaks %}
{% block head %}
<title>分享</title>
<link href="{% static 'css/food_create.css' %}" rel="stylesheet">
<style type="text/css">
    .errorlist {
        color: red;
    }
</style>
{% endblock head %}
{% block content %}
<div class="create-container">
    <div class="title">
        分享
    </div>

    <form class="create-form" action="." method="post" enctype="multipart/form-data">
        {% csrf_token %}
        <div class="form-item">
            <label class="form-label">封面图片</label>
            {{ form.cover_image.errors }}
            <div class="preview-main clearfix">
                <div class="preview-img" id="preview-img" style="background-image: url('/public/static/images/topic1.jpg')"></div>
                <label for="upload" class="upload">
                    + 上传图片
                </label>
                {{ form.cover_image | attr:"id:upload"}}
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-title">标题</label>
            {{ form.title.errors }}
            <div class="item-input">
                {{ form.title | add_class:"input" | attr:"placeholder:请输入标题"}}
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-type">分类</label>
            {{ form.category.errors }}
            <div class="selections">
                {{ form.category | add_class:"types" }}
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-tag">标签</label>
            {{ form.tags.errors }}
            <div class="item-input">
                {{ form.tags | add_class:"input" | attr:"placeholder:请输入标签，以逗号分隔" }}
              <!--   <input type="text" name="tag" class="input" id="create-tag" placeholder="请输入标签">
                <div class="add-tag" id="add-tag">
                    +
                </div>
                <div class="tag-preview" id="tag-preview">
                    
                </div> -->
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-link">来源链接</label>
            {{ form.link.errors }}
            <div class="item-input">
                <input type="url" name="link" class="input" id="create-link" placeholder="http://">
            </div>
        </div>

        <div class="form-item">
            <label class="form-label" for="create-desc">简介</label>
            {{ form.description.errors }}
            <div class="item-input">
                {{ form.description | add_class:"textarea" | attr:"placeholder:请输入简介" }}
                <!-- <textarea name="desc" rows="8" cols="40" id="desc" class="textarea"></textarea> -->
            </div>
        </div>

        <div class="form-item btn-item">
            <button type="submit" name="share" class="form-btn share-btn">分享</button>
            <button type="reset" name="cancel" class="form-btn cancel-btn">重置</button>
        </div>
    </form>

</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/food_create.js' %}"></script>
{% endblock js %}