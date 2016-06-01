webpackJsonp([1],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	module.exports = __webpack_require__(304);


/***/ },

/***/ 304:
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	__webpack_require__(300);
	__webpack_require__(305);
	window.$ajax = __webpack_require__(303);

	(function () {
	    var likeDom = $("like");
	    var dislikeDom = $("dislike");
	    var shareDom = $("share");
	    var wantDom = $("want");
	    var eatedDom = $("eated");

	    likeDom.click(function (event) {
	        var self = this;

	        $ajax({
	            url: url,
	            method: "GET",
	            data: {
	                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
	            }
	        }).then(function (data) {
	            self.className = "circle liked";
	            dislikeDom.className = "circle";
	            shareDom.className = "circle";
	        }).catch(function (error) {
	            alert("网络异常");
	        });
	    });

	    dislikeDom.click(function (event) {
	        var self = this;

	        $ajax({
	            url: url,
	            method: "GET",
	            data: {
	                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
	            }
	        }).then(function (data) {
	            self.className = "circle liked";
	            likeDom.className = "circle";
	            shareDom.className = "circle";
	        }).catch(function (error) {
	            alert("网络异常");
	        });
	    });

	    wantDom.click(function (event) {
	        var self = this;

	        $ajax({
	            url: url,
	            method: "GET",
	            data: {
	                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
	            }
	        }).then(function (data) {
	            self.className = "icon clicked";
	            eatedDom.className = "icon";
	        }).catch(function (error) {
	            alert("网络异常");
	        });
	    });

	    eatedDom.click(function (event) {
	        var self = this;

	        $ajax({
	            url: url,
	            method: "GET",
	            data: {
	                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
	            }
	        }).then(function (data) {
	            self.className = "icon clicked";
	            wantDom.className = "icon";
	        }).catch(function (error) {
	            alert("网络异常");
	        });
	    });
	})();

/***/ },

/***/ 305:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ }

});
