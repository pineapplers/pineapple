{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% block head %}
<link href="{% static 'css/user_profile.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="tab-container">
    <div class="form-container">
        <form class="form" action="index.html" method="post">
            <div class="form-item">
                <label class="form-item-label" for="">设置头像</label>
                <div class="img-preview">
                    <span class="table-vertical" id="preview-span"><img src="/public/static/images/topic1.jpg" alt="背景预览"></span>
                </div>
                <input class="form-item-file" id="preview-input" type="file" name="newPortrait" value="">
            </div>

            <div class="form-item">
                <label class="form-item-label">居住城市</label>
                <select class="selections" name="province">
                    <option value="广东">广东</option>
                    <option value="北京">北京</option>
                </select>
                <span class="form-span">省</span>
                <select class="selections" name="city">
                    <option value="珠海">珠海</option>
                    <option value="广州">广州</option>
                </select>
                <span class="form-span">市</span>
            </div>

            <div class="form-item">
                <label class="form-item-label">出生日期</label>
                <select class="selections" name="year">
                    <option value="2016">2016</option>
                    <option value="2015">2015</option>
                </select>
                <span class="form-span">年</span>
                <select class="selections" name="month">
                    <option value="06">06</option>
                    <option value="05">05</option>
                </select>
                <span class="form-span">月</span>
                <select class="selections" name="day">
                    <option value="21">21</option>
                    <option value="20">20</option>
                </select>
                <span class="form-span">日</span>
            </div>

            <div class="form-item">
                <label class="form-item-label">性别</label>
                <input class="radio" type="radio" name="sex" value="male" id="male">
                <label class="form-radio-label" for="male">男</label>

                <input class="radio" type="radio" name="sex" value="male" id="female" style="margin-left: 10px">
                <label class="form-radio-label" for="female">女</label>
            </div>

            <div class="form-item">
                <label class="form-item-label">个人简介</label>
                <textarea class="form-textarea" name="personalDesc" rows="8" cols="50"></textarea>
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
<script src="{% static 'js/user_profile.js' %}"></script>
{% endblock js %}
