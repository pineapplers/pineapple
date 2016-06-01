require("../../css/common.less");
require("../../css/user/base.less");
require("../../css/user/list.less");
window.$ajax = require("../../commonJSFile/ajax.js");
var url = "https://api.unsplash.com/photos/random";
// "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"

(function() {
    let container = $("user-item-container");

    container.click(function(event) {
        let e = window.event || event;
        let target = e.srcElement || e.target;
        let self = this;

        $ajax({
            url: url,
            method: "GET",
            data: {
                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
            }
        }).then(function(data) {
            target.innerHTML = "取消关注";
            target.className = "user-item-follow-btn has-follow";
        }).catch(function(error) {
            alert("网络异常");
        });
    });
})();
