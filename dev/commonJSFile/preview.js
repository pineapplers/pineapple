module.exports = function() {
    function preview(file) {
        var prevDiv = document.getElementById('preview-span');
        var file = this;
        if (file.files && file.files[0])
        {
            var reader = new FileReader();
            reader.onload = function(evt){
                prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
            }
            reader.readAsDataURL(file.files[0]);
        }
        else
        {
            prevDiv.innerHTML = '<img src="' + file.value + '" />';
        }
    }

    document.getElementById("preview-input").addEventListener("change", preview, false)
};
