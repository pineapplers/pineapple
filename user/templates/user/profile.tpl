{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% load widget_tweaks %}
{% block head %}
<link href="{% static 'css/user_profile.css' %}" rel="stylesheet">
{% endblock head %}
{% block content %}
<div class="tab-container">
    <div class="form-container">
        <form class="form" action="." method="post">
            {% csrf_token %}
            <div class="form-item">
                <label class="form-item-label" for="">设置头像</label>
                <div class="img-preview">
                    <span class="table-vertical" id="preview-span">
                        <img src="{{ MEDIA_URL }}{{ profile.avatar }}" alt="背景预览">
                    </span>
                </div>
                {{ form.avatar | attr:"id:preview-input"}}
            </div>

            <div class="form-item">
                <label class="form-item-label">居住城市</label>
                {{ form.location | add_class:"selections" | attr:"id:city" }}
                <span class="form-span">市</span>
                <select class="selections" id="province">
                    <option>请选择</option>
                    {% for province in provinces %}
                    <option>{{ province }}</option>
                    {% endfor %}
                </select>
                <span class="form-span">省</span>
                
            </div>

            <div class="form-item">
                <label class="form-item-label">出生日期</label>
                {{ form.date_of_birth | add_class:"selections"}}
            </div>

            <div class="form-item">
                <label class="form-item-label">性别</label>
                {{ form.gender | add_class:"selections" }}
            </div>

            <div class="form-item">
                <label class="form-item-label">个人简介</label>
                {{ form.introduction | add_class:"form-textarea" | attr:"rows:8" | attr:"cols:50"}}
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
<script type="text/javascript">
    $(function() {
        $("#province").change(function(ev) {
            var province = this.value;
            $.ajax({
                url: "{% url 'user:get_cities' %}",
                type: 'GET',
                data: {
                    'province': province
                }
            }).success(function(cities) {
                $('#city').empty();
                $.each(cities, function (i, city) {
                    $('#city').append($('<option>', { 
                        value: city[0],
                        text : city[1]
                    }));
                });
            }).error(function() {
                alert('网络异常');
            });
        });
    });
</script>
{% endblock js %}
