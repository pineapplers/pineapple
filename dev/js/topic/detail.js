require("../../css/common.less");
require("../../css/topic/detail.less");
window.$ajax = require("../../commonJSFile/ajax.js");
var url = "https://api.unsplash.com/photos/random";
// "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"

(function() {
    let collectDom = $("collect");

    collectDom.click(function(event) {
        let self = this;

        $ajax({
            url: url,
            method: "GET",
            data: {
                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
            }
        }).then(function(data) {
            self.innerHTML = "已收藏";
            self.className = "collected";
        }).catch(function(error) {
            alert("网络异常");
        });
    });
})();
