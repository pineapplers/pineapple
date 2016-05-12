from django.shortcuts import render

def search(request, query_string):
	return render(request, 'search/search.tpl')

