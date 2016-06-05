
from .forms import SearchForm

def search_proc(request):
    form = SearchForm()
    return {
        'search_form': form
    }