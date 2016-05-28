require("../../css/common.less");
require("../../css/home/index.less");

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
