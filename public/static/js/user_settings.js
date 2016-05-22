webpackJsonp([11],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	__webpack_require__(7);
	__webpack_require__(13);
	__webpack_require__(14)();


/***/ },

/***/ 7:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },

/***/ 13:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },

/***/ 14:
/***/ function(module, exports) {

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


/***/ }

});