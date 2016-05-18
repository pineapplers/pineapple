{% extends 'user/base.tpl' %}
{% load staticfiles %}
{% block head %}
<link rel="stylesheet" href="{% static 'css/user_list.css' %}"></link>
{% endblock head %}
{% block content %}
 <div class="tab-container">
            <div class="user-item-container clearfix">
                <div class="user-item">
                    <a href="#"><div class="user-item-portrait"></div></a>
                    <a href="#"><span class="user-item-info">滨滨和泓泓</span></a>
                    <a href="#"><span class="user-item-info">45,012 人关注他</span></a>
                    <a href="#"><button type="button" name="follow" class="user-item-follow-btn">关注</button></a>
                </div>

                <div class="user-item">
                    <a href="#"><div class="user-item-portrait"></div></a>
                    <a href="#"><span class="user-item-info">滨滨和泓泓</span></a>
                    <a href="#"><span class="user-item-info">45,012 人关注他</span></a>
                    
                    <a href="#"><button type="button" name="follow" class="user-item-follow-btn has-follow">取消关注</button></a>
                </div>

                <div class="user-item">
                    <a href="#"><div class="user-item-portrait"></div></a>
                    <a href="#"><span class="user-item-info">滨滨和泓泓</span></a>
                    <a href="#"><span class="user-item-info">45,012 人关注他</span></a>
                    <a href="#"><button type="button" name="follow" class="user-item-follow-btn">关注</button></a>
                </div>

                <div class="user-item">
                    <a href="#"><div class="user-item-portrait"></div></a>
                    <a href="#"><span class="user-item-info">滨滨和泓泓</span></a>
                    <a href="#"><span class="user-item-info">45,012 人关注他</span></a>
                    <a href="#"><button type="button" name="follow" class="user-item-follow-btn">关注</button></a>
                </div>

                <div class="user-item">
                    <a href="#"><div class="user-item-portrait"></div></a>
                    <a href="#"><span class="user-item-info">滨滨和泓泓</span></a>
                    <a href="#"><span class="user-item-info">45,012 人关注他</span></a>
                    <a href="#"><button type="button" name="follow" class="user-item-follow-btn">关注</button></a>
                </div>

                <div class="user-item">
                    <a href="#"><div class="user-item-portrait"></div></a>
                    <a href="#"><span class="user-item-info">滨滨和泓泓</span></a>
                    <a href="#"><span class="user-item-info">45,012 人关注他</span></a>
                    <a href="#"><button type="button" name="follow" class="user-item-follow-btn">关注</button></a>
                </div>

                <div class="user-item">
                    <a href="#"><div class="user-item-portrait"></div></a>
                    <a href="#"><span class="user-item-info">滨滨和泓泓</span></a>
                    <a href="#"><span class="user-item-info">45,012 人关注他</span></a>
                    <a href="#"><button type="button" name="follow" class="user-item-follow-btn">关注</button></a>
                </div>

                <div class="user-item">
                    <a href="#"><div class="user-item-portrait"></div></a>
                    <a href="#"><span class="user-item-info">滨滨和泓泓</span></a>
                    <a href="#"><span class="user-item-info">45,012 人关注他</span></a>
                    <a href="#"><button type="button" name="follow" class="user-item-follow-btn">关注</button></a>
                </div>
            </div>

        </div>
{% endblock content %}
{% block js %}
<script src="{% static 'js/user_list.js' %}"></script>
{% endblock js %}

