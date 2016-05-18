webpackJsonp([6],[
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	__webpack_require__(4);
	__webpack_require__(10);
	__webpack_require__(11)();


/***/ },
/* 1 */,
/* 2 */,
/* 3 */,
/* 4 */
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },
/* 5 */,
/* 6 */,
/* 7 */,
/* 8 */,
/* 9 */,
/* 10 */
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ },
/* 11 */
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
]);