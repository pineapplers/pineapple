webpackJsonp([5],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	module.exports = __webpack_require__(312);


/***/ },

/***/ 312:
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	__webpack_require__(300);
	__webpack_require__(313);
	window.$ajax = __webpack_require__(303);
	var url = "https://api.unsplash.com/photos/random";
	// "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"

	(function () {
	    var collectDom = $("collect");

	    collectDom.click(function (event) {
	        var self = this;

	        $ajax({
	            url: url,
	            method: "GET",
	            data: {
	                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
	            }
	        }).then(function (data) {
	            self.innerHTML = "已收藏";
	            self.className = "collected";
	        }).catch(function (error) {
	            alert("网络异常");
	        });
	    });
	})();

/***/ },

/***/ 313:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ }

});