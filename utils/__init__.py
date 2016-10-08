#-*- coding:utf-8 -*-
from django.core.paginator import Paginator, InvalidPage, EmptyPage
from django.core.cache import cache

# Create your views here.
def make_paginator(request, items, per_page=10, cache_key=None, cache_time=0, cahce_pages=10):
    """Make paginator."""
    try: 
        page = int(request.GET.get("page", '1'))
    except ValueError: 
        page = 1

    if cache_key:
        _items = cache.get('{}:{}'.format(cache_key, page))
        if _items:
            return _items

    paginator = Paginator(items, per_page)
    try:
        items = paginator.page(page)
    except (InvalidPage, EmptyPage):
        items = paginator.page(paginator.num_pages)

    if cache_key and page < cahce_pages:
        # 缓存分页
        cache.set('{}:{}'.format(cache_key, page), items, cache_time)
    return items