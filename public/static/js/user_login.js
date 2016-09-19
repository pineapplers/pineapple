webpackJsonp([11],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	module.exports = __webpack_require__(323);


/***/ },

/***/ 323:
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	__webpack_require__(299);
	__webpack_require__(324);
	var formAnimate = __webpack_require__(325);
	formAnimate();
	window.$ajax = __webpack_require__(302);

/***/ },

/***/ 324:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },

/***/ 325:
/***/ function(module, exports) {

	"use strict";

	module.exports = function () {
	    var loginContainer = document.getElementById("form-container");
	    var inputs = loginContainer.getElementsByTagName("input");

	    for (var idx = 0; idx < inputs.length; idx++) {
	        inputs[idx].addEventListener("focus", function (event) {
	            var e = window.event || event;
	            var target = e.srcElement || e.target;
	            if (target.name === "button") {
	                return;
	            }
	            var label = target.parentNode.firstElementChild;
	            label.className = "focus-label";
	        }, false);

	        inputs[idx].addEventListener("blur", function (event) {
	            var e = window.event || event;
	            var target = e.srcElement || e.target;
	            if (target.value === "") {
	                var label = target.parentNode.firstElementChild;
	                label.className = "";
	                target.className = "";
	            } else {
	                target.className = "compvare-input";
	            }
	        }, false);
	    }
	};

/***/ }

});