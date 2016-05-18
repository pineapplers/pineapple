from django.http import HttpResponse

# 404
def page_not_found(request):
    return HttpResponse('page not found!')

# 500
def server_err(request):
    return HttpResponse('server error')
