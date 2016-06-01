require("../../css/common.less");
require("../../css/home/index.less");
window.$ajax = require("../../commonJSFile/ajax.js");
// window.url = "https://api.unsplash.com/photos/random";
// "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"

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
