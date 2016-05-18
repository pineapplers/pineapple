{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% block head %}
<link href="{% static 'css/user_settings.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="tab-container">
    <div class="form-container">

        <form class="form" action="index.html" method="post">
            <div class="form-item">
                <label class="form-item-label" for="">设置背景</label>
                <div class="img-preview">
                    <span class="table-vertical" id="preview-span"><img src="/public/static/images/topic1.jpg" alt="背景预览"></span>
                </div>
                <input class="form-item-file" id="preview-input" type="file" name="newBack" value="">
            </div>

            <div class="form-item">
                <div class="form-item-btn">
                    <input type="submit" name="submit" value="保存" id="submit">
                    <input type="submit" name="logout" value="注销账号" id="logout">
                    
                </div>
            </div>
        </form>
    </div>
</div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_settings.js' %}"></script>
{% endblock js %}