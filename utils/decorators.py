from functools import wraps
from django.http import HttpResponseBadRequest

def ajax_required(view):
    @wraps(view)
    def wrapper(request, *args, **kws):
        if not request.is_ajax():
            return HttpResponseBadRequest()
        return view(request, *args, **kws)
    return wrapper
    