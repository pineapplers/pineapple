webpackJsonp([0],{

/***/ 0:
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);
	module.exports = __webpack_require__(298);


/***/ },

/***/ 298:
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	__webpack_require__(299);
	__webpack_require__(301);
	window.$ajax = __webpack_require__(302);

	(function () {
	    function preview() {
	        var prevDiv = document.getElementById('preview-img');
	        var file = this;
	        if (file.files && file.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function (evt) {
	                prevDiv.style.backgroundImage = "url('" + evt.target.result + "')";
	            };
	            reader.readAsDataURL(file.files[0]);
	        } else {
	            prevDiv.style.backgroundImage = "url('" + file.value + "')";
	        }
	    }

	    document.getElementById("upload").addEventListener("change", preview, false);
	})();

	(function () {
	    var tag_input = document.getElementById("create-tag");
	    var tag_add_btn = document.getElementById("add-tag");
	    var tagContainer = document.getElementById("tag-preview");
	    var tags = [];
	    var tagsFlag = {};
	    var tagCount = 0;

	    tag_add_btn.addEventListener("click", function (event) {
	        if (tag_input.value !== "") {
	            // 标签输入处理
	            var val_result = tag_input.value.split(/[,|，]/);
	            for (var i = 0; i < val_result.length; i++) {
	                if (!tagsFlag[val_result[i]] && val_result[i] !== "") {
	                    tagContainer.innerHTML += "<div class=\"tag\"><span>" + val_result[i] + "</span><span class=\"tag-delete\">x</span></div>";
	                    tags.push(val_result[i]);
	                    tagsFlag[val_result[i]] = true;
	                }
	            }
	            console.log(tags);
	            tag_input.value = "";
	            tag_input.focus();
	        }
	    }, false);

	    tagContainer.addEventListener("click", function (event) {
	        var e = window.event || event;
	        var target = e.srcElement || e.target;

	        if (target.className === "tag-delete") {
	            var val = target.previousElementSibling.innerHTML;
	            for (var idx = 0; idx < tags.length; idx++) {
	                if (tags[idx] === val) {
	                    tags.splice(idx, 1);
	                    tagsFlag[val] = false;
	                    break;
	                }
	            }
	            this.removeChild(target.parentNode);
	        }
	    }, false);

	    // 表单提交前拦截处理
	    (function formFilter() {
	        var form = document.getElementById("create-form");

	        form.addEventListener("submit", function () {
	            tag_input.value = tags.join(",");
	            return true;
	        });
	    })();
	})();

/***/ },

/***/ 301:
/***/ function(module, exports) {

	// removed by extract-text-webpack-plugin

/***/ }

});