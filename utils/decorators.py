from functools import wraps
from django.http import HttpResponseBadRequest

def ajax_required(view):
    @wraps(view)
    def wrapper(request, *args, **kws):
        if not request.is_ajax():
            return HttpResponseBadRequest()
        return view(request, *args, **kws)
    return wrapper
    
def tab(tab, *, sub_tab=None):
    def wrapper(view):
        @wraps(view)
        def _wrapper(request, *args, **kws):
            request.TAB = tab
            request.SUBTAB = sub_tab
            return view(request, *args, **kws)
        return _wrapper
    return wrapper