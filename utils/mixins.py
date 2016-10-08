#-*- coding:utf-8 -*-
import bleach
from django.conf import settings

class CleanContentMixin:
    # 防御富文本编辑器造成的XSS注入
    def clean_content(self):
        content = self.cleaned_data.get('content', '')
        cleaned_text = bleach.clean(content, settings.BLEACH_VALID_TAGS, settings.BLEACH_VALID_ATTRS, settings.BLEACH_VALID_STYLES)
        return cleaned_text