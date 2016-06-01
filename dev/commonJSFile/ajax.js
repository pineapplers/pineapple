module.exports = function({url = false, method = "GET", data = null} = {}) {
    // xhr 获取数据成功
    let isReady = (xhr) => {
        return xhr.readyState === 4 && xhr.status >= 200 && xhr.status < 300;
    };

    // xhr 获取数据失败
    let isFailed = (xhr) => {
        return xhr.readyState === 4 && xhr.status !== 0 && (xhr.status < 200 || xhr.status >= 300);
    };

    // 判断 "object" 类型
    let isObject = (obj) => {
        return typeof obj === "object" && obj !== null;
    };

    // 判断 xhr 获取方法为 "GET"
    let isGET = (method) => {
        return method === "GET" || method === "get" || method === "Get";
    };

    // 判断 xhr 获取方法为 "POST"
    let isPOST = (method) => {
        return method === "POST" || method === "post" || method === "Post";
    };

    // 以 "GET" 形式开始获取数据
    let startWithGet = (xhr) => {
        xhr.open("GET", url + "?" + arrangeData(data), true);
        xhr.send(null);
    };

    // 以 "POST" 形式开始获取数据
    let startWithPost = (xhr) => {
        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send(arrangeData(data));
    }

    // 将 object 类型的对象变为可迭代的对象
    function* iteratorOfData(obj) {
        for (let key of Object.keys(obj)) {
            yield [key, obj[key]];
        }
    }

    // 格式化数据
    let arrangeData = (data) => {
        if(data !== null && isObject(data)) {
            let result = "";
            let flag = "";
            for(let [key, value] of iteratorOfData(data)) {
                result += flag;
                flag = "&";
                result += (key + "=" + value);
            }
            return result;
        }

        return "";
    };


    let ajax = new Promise((resolve, reject) => {
        if(!url) {
            reject(new Error("Please input a URL"));
            return null;
        }

        let xhr = null;

        if(window.XMLHttpRequest) {
            xhr = new XMLHttpRequest();
        }else if(window.ActiveXObject) {
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        }else {
            throw new Error("Your browser do not support XMLHttpRequest or ActiveXObject, please update your browser!");
        }

        let readyStateChangeEvent = function() {
            if(isReady(this)) {
                resolve(JSON.parse(this.responseText));
            }else if(isFailed(this)) {
                reject({
                    xhr: xhr,
                    status: xhr.status
                });
            }
        };

        if(xhr !== null) {
            xhr.onreadystatechange = readyStateChangeEvent;

            if(isGET(method)) {
                startWithGet(xhr);
            }else if(isPOST(method)) {
                startWithPost(xhr);
            }else {
                xhr.open(method, url, true);
                xhr.send(arrangeData(data));
            }
        }
    });

    return ajax;
};
