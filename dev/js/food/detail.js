require("../../css/common.less");
require("../../css/food/detail.less");
window.$ajax = require("../../commonJSFile/ajax.js");
var url = "https://api.unsplash.com/photos/random";
// "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"

(function() {
    let likeDom = $("like");
    let dislikeDom = $("dislike");
    let shareDom = $("share");
    let wantDom = $("want");
    let eatedDom = $("eated");

    likeDom.click(function(event) {
        let self = this;

        $ajax({
            url: url,
            method: "GET",
            data: {
                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
            }
        }).then(function(data) {
            self.className = "circle liked";
            dislikeDom.className = "circle";
            shareDom.className = "circle";
        }).catch(function(error) {
            alert("网络异常");
        });
    });

    dislikeDom.click(function(event) {
        let self = this;

        $ajax({
            url: url,
            method: "GET",
            data: {
                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
            }
        }).then(function(data) {
            self.className = "circle liked";
            likeDom.className = "circle";
            shareDom.className = "circle";
        }).catch(function(error) {
            alert("网络异常");
        });
    });

    wantDom.click(function(event) {
        let self = this;

        $ajax({
            url: url,
            method: "GET",
            data: {
                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
            }
        }).then(function(data) {
            self.className = "icon clicked";
            eatedDom.className = "icon";
        }).catch(function(error) {
            alert("网络异常");
        });
    });

    eatedDom.click(function(event) {
        let self = this;

        $ajax({
            url: url,
            method: "GET",
            data: {
                client_id: "fa60305aa82e74134cabc7093ef54c8e2c370c47e73152f72371c828daedfcd7"
            }
        }).then(function(data) {
            self.className = "icon clicked";
            wantDom.className = "icon";
        }).catch(function(error) {
            alert("网络异常");
        });
    });
})();
