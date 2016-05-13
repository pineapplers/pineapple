webpackJsonp([2,4],[
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	__webpack_require__(5);

	(function() {
	    var loginContainer = document.getElementById("form-container");
	    var inputs = loginContainer.getElementsByTagName("input")

	    for(var idx=0;idx<inputs.length;idx++) {
	        inputs[idx].addEventListener("focus", function(event) {
	            var e = window.event || event;
	            var target = e.srcElement || e.target;
	            if(target.name === "button") {
	                return;
	            }
	            var label = target.parentNode.firstElementChild;
	            label.className = "focus-label";
	        }, false);

	        inputs[idx].addEventListener("blur", function(event) {
	            var e = window.event || event;
	            var target = e.srcElement || e.target;
	            if(target.value === "") {
	                var label = target.parentNode.firstElementChild;
	                label.className = "";
	                target.className = "";
	            }else {
	                target.className = "compvare-input";
	            }
	        }, false);
	    }
	})();


/***/ },
/* 1 */
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },
/* 2 */,
/* 3 */,
/* 4 */,
/* 5 */
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ }
]);