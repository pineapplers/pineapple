webpackJsonp([12],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	module.exports = __webpack_require__(326);


/***/ },

/***/ 316:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },

/***/ 326:
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	__webpack_require__(299);
	__webpack_require__(316);
	__webpack_require__(327);
	__webpack_require__(328)();
	window.$ajax = __webpack_require__(302);

/***/ },

/***/ 327:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },

/***/ 328:
/***/ function(module, exports) {

	'use strict';

	module.exports = function () {
	    function preview(file) {
	        var prevDiv = document.getElementById('preview-span');
	        var file = this;
	        if (file.files && file.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function (evt) {
	                prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
	            };
	            reader.readAsDataURL(file.files[0]);
	        } else {
	            prevDiv.innerHTML = '<img src="' + file.value + '" />';
	        }
	    }

	    document.getElementById("preview-input").addEventListener("change", preview, false);
	};

/***/ }

});