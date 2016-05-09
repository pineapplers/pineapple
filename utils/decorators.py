from functools import wraps
from django.http import HttpResponseBadRequest

def ajax_required(view):
    @wraps
    def wrapper(request, *args, **kws):
        if not request.is_ajax():
            return HttpResponseBadRequest()
        return wrapper(request, *args, **kws)
    return wrapper
    