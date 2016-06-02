function csrfSafeMethod(method) {
    return (/^(GET|HEAD|OPTION|TRACE)$/.test(method));
}

$.ajaxSetup({
    crossDomain: false,
    beforeSend: function(xhr, settings) {
        if (!csrfSafeMethod(settings.type)) {
            xhr.setRequestMethod("X-CSRFToken", csrftoken);
        }       
    }
});
