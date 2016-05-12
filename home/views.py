from django.shortcuts import render

from search.forms import form = SearchForm()

# Create your views here.
def home(request):
	form = SearchForm()
    if request.user.is_authenticated():
        # 
        pass
    else:
        pass
    return render(request, 'home/index.tpl', {
    		'form': form
    	})
    