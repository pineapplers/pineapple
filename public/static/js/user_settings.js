webpackJsonp([14],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	module.exports = __webpack_require__(331);


/***/ },

/***/ 317:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },

/***/ 328:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },

/***/ 329:
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

/***/ },

/***/ 331:
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	__webpack_require__(300);
	__webpack_require__(317);
	__webpack_require__(328);
	__webpack_require__(329)();
	window.$ajax = __webpack_require__(303);

/***/ }

});