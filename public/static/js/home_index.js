webpackJsonp([4],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	__webpack_require__(7);

	(function() {
	    var container = document.getElementById("container");
	    var clientHeight = document.documentElement.clientHeight;
	    var first = true;
	    container.style.height = clientHeight + "px";

	    document.addEventListener("scroll", function() {
	        if(document.body.scrollTop > clientHeight / 2 && first) {
	            first = false;
	            document.getElementById("navbar").className += " over-navbar";
	        }else if(document.body.scrollTop < clientHeight / 2 - 1 && !first) {
	            first = true;
	            document.getElementById("navbar").className = "navbar";
	        }
	    }, false);
	})();


/***/ },

/***/ 7:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ }

});