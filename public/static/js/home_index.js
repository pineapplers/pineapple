webpackJsonp([4],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	module.exports = __webpack_require__(310);


/***/ },

/***/ 310:
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	__webpack_require__(300);
	__webpack_require__(311);
	window.$ajax = __webpack_require__(303);
	// window.url = "https://api.unsplash.com/photos/random";
	// "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"

	(function () {
	    var container = document.getElementById("container");
	    var clientHeight = document.documentElement.clientHeight;
	    var first = true;
	    container.style.height = clientHeight + "px";

	    document.addEventListener("scroll", function () {
	        if (document.body.scrollTop > clientHeight / 2 && first) {
	            first = false;
	            document.getElementById("navbar").className += " over-navbar";
	        } else if (document.body.scrollTop < clientHeight / 2 - 1 && !first) {
	            first = true;
	            document.getElementById("navbar").className = "navbar";
	        }
	    }, false);
	})();

/***/ },

/***/ 311:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ }

});