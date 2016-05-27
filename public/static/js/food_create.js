webpackJsonp([0],[
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	__webpack_require__(3);


	(function() {
	    function preview() {
	        var prevDiv = document.getElementById('preview-img');
	        var file = this;
	        if (file.files && file.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function(evt) {
	                prevDiv.style.backgroundImage = "url('" + evt.target.result + "')";
	            }
	            reader.readAsDataURL(file.files[0]);
	        }else {
	            prevDiv.style.backgroundImage = "url('" + file.value + "')"
	        }
	    }

	    document.getElementById("upload").addEventListener("change", preview, false);
	})();

	(function() {
	    var tag_input = document.getElementById("create-tag");
	    var tag_add_btn = document.getElementById("add-tag");
	    var tagContainer = document.getElementById("tag-preview");

	    tag_add_btn.addEventListener("click", function(event) {
	        if(tag_input.value !== "") {
	            tagContainer.innerHTML += "<div class=\"tag\">" + tag_input.value + "<span class=\"tag-delete\">x</span></div>";
	            tag_input.value = "";
	            tag_input.focus();
	        }
	    }, false);

	    tagContainer.addEventListener("click", function(event) {
	        var e = window.event || event;
	        var target = e.srcElement || e.target;

	        if(target.className === "tag-delete") {
	            this.removeChild(target.parentNode);
	        }
	    }, false);
	})();


/***/ },
/* 1 */,
/* 2 */,
/* 3 */
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ }
]);