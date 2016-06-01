webpackJsonp([10],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	module.exports = __webpack_require__(322);


/***/ },

/***/ 317:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },

/***/ 322:
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	__webpack_require__(300);
	__webpack_require__(317);
	__webpack_require__(323);
	window.$ajax = __webpack_require__(303);
	var url = "https://api.unsplash.com/photos/random";
	// "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"

	(function () {
	    var container = $("user-item-container");

	    container.click(function (event) {
	        var e = window.event || event;
	        var target = e.srcElement || e.target;
	        var self = this;

	        $ajax({
	            url: url,
	            method: "GET",
	            data: {
	                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
	            }
	        }).then(function (data) {
	            target.innerHTML = "取消关注";
	            target.className = "user-item-follow-btn has-follow";
	        }).catch(function (error) {
	            alert("网络异常");
	        });
	    });
	})();

/***/ },

/***/ 323:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ }

});