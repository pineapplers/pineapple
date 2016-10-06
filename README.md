# pineapple

发现好吃的，好玩的🍍

[演示地址](http://182.254.232.181/)

## intro

pineapple是一个基于吃货分享的社区。

功能：

 - 分享有趣的食物
 - 浏览和评论美食专题和介绍
 - 轻量简约的社区和社交形式

## 部署

依赖环境

 - mysql
 - redis
 - python3.x(virtualenv)

初始化

```
pip3 install requirements.txt
python3 manager.py makemigrations
python3 manager.py makemigrations thumbnail
python3 manager.py migrate
```

测试运行

```
python3 manager.py runserver
```
   
## demo

首页

![home](http://ww2.sinaimg.cn/large/006y8lVagw1f8irflhs4oj31kw0uygub.jpg)

专题页

![topic](http://ww2.sinaimg.cn/large/006y8lVagw1f8irh8bljrj31kw0w9q6y.jpg)

专题内容

![topic-detail](http://ww2.sinaimg.cn/large/006y8lVagw1f8iri902zsj31kw0w7dqf.jpg)

发现页

![explore](http://ww3.sinaimg.cn/large/006y8lVagw1f8irhj3lt7j31kw0w6n1a.jpg)

列表页

![food](http://ww4.sinaimg.cn/large/006y8lVagw1f8irkb4jhpj31kw0w8ae4.jpg)

详情页

![food-detail](http://ww3.sinaimg.cn/large/006y8lVagw1f8irhtvqnnj31kw0w7tgf.jpg)

用户页

![user](http://ww2.sinaimg.cn/large/006y8lVagw1f8irit353pj31kw0w6juj.jpg)

私信功能

![chat](http://ww3.sinaimg.cn/large/006y8lVagw1f8irj3uim9j31kw0w7n0u.jpg)

讨论区

![forum](http://ww2.sinaimg.cn/large/006y8lVagw1f8irjhetb7j31kw0w577f.jpg)

评论页

![post-detail](http://ww3.sinaimg.cn/large/006y8lVagw1f8irko9zx6j31kw0w841p.jpg)

分享页

![share](http://ww4.sinaimg.cn/large/006y8lVagw1f8irjua6e5j31kw0w6adk.jpg)

注册页

![register](http://ww1.sinaimg.cn/large/006y8lVagw1f8iriigwwmj31kw0w7gom.jpg)