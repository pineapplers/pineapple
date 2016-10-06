$(function() {
    var messages = {};
    var contacts = {};
    var lastTime = 0;
    var openBox = false;
    var currentContact = -1;
    var userId = -1;
    var unReadCount = 0;

    function getUserId() {
        $.ajax({
            url: "/user/whoami/",
            method: "GET",
        }).success(function(resp) {
            if (resp.status == true) {
                userId = resp.id;
                Cookies.set('userId', userId);
            }
        }).error(function() {
            alert('网络错误，请刷新页面')
        });
    }

    function getCurrentUser() {
        if (userId < 0) {
            var id = Cookies.get('userId');
            if (id != undefined) {
                return id;
            } else {
                getUserId();
            }
        }
        return userId;
    }

    function recordAppend(side, msg) {
        $('.chat-record').append(
            '<div class="record-item ' + side +' "style="clear:both;">' + 
              '<div class="record">' + msg + '</div>' +
            '</div>'
        );
    }

    function freshChatBox(contactId) {
        $(".chat-record *").remove();
        var msgs = messages[contactId];
        $(".chat-title").text(contacts[contactId]['name']);
        msgs.forEach(function(msg, index) {
            var side = 'sender';
            if (msg.from == getCurrentUser()) {
                side = 'receiver';
            }
            recordAppend(side, msg.msg);
        });
    }

    function handleNewMessages(data, push) {
        if (data.length > 0) {
            var currentUser = getCurrentUser();
            data.forEach(function(msg, index){
                if (msg.from == currentUser) {
                    if (!messages.hasOwnProperty(msg.to)) {
                        messages[msg.to] = [];
                    }
                    if (push == true) {
                        messages[msg.to].push(msg);
                    } else {
                        messages[msg.to].unshift(msg);
                    }
                } else {
                    if (!messages.hasOwnProperty(msg.from)) {
                        messages[msg.from] = [];
                    }
                    if (push == true) {
                        messages[msg.from].push(msg);
                    } else {
                        messages[msg.from].unshift(msg);
                    }
                }
                if (msg.t > lastTime) {
                    lastTime = msg.t;
                }
            });
        }
        
        loadContacts(function(){
            if (currentContact > 0) {
                freshChatBox(currentContact);
            }
        });
    }

    function pullAttention() {
        $.ajax({
            url: "/message/attention/",
            method: "GET",
        }).success(function(resp) {
            unReadCount = resp.count;
            if (unReadCount > 0 && openBox == false) {
                $(".redpoint").show();
                $("#msg-count").text(unReadCount.toString());
            } else {
                $(".redpoint").hide();
                $("#msg-count").text("0");
            }
        }).done(function(){
            if (openBox == false) {
                setTimeout(pullAttention, 10000);
            }
        });
    }

    function pullMessages() {
        $.ajax({
            url: "/message/new/",
            method: "GET",
            data: {
                'time': lastTime
            }
        }).success(function(resp) {
            if (resp.status == true) {
                handleNewMessages(resp.data, true);
            }
        }).done(function() {
            if (openBox == true) {
                setTimeout(pullMessages, 5000);
            }
        });
    }

    function sendMessage(text) {
        if (currentContact < 0) {
            alert('请选择联系人');
            return;
        }
        $.ajax({
            url: "/message/send/",
            method: "POST",
            data: {
                'msg': text,
                'user': currentContact
            }
        }).success(function(resp) {
            if (resp.status == true) {
                recordAppend('receiver', text);
            } else {
                alert('发送失败');
            }
        }).error(function(resp) {
            alert('网络错误');
        }).done(function() {
            $("#send-msg").val("");
        });
    }

    function loadContacts(callback) {
        var user_ids = [];
        for (var id in messages) {
            if (!contacts.hasOwnProperty(id)) {
                user_ids.push(id);
            }
        }
        if (user_ids.length > 0) {
            $.ajax({
                url: "/message/profile/",
                method: "POST",
                data: {
                    'ids': JSON.stringify(user_ids)
                }
            }).success(function(resp) {
                if (resp.status == true) {
                    $(".chat-users *").remove();
                    resp.data.forEach(function(contact, index){
                    console.log(contact.avatar);
                        contacts[contact.user] = contact;
                        $(".chat-users").prepend(
                            '<li class="users-list-item clearfix" data-id=' + contact.user + '>' +
                              '<div class="portrait" style="background-image: url(/media/'+ contact.avatar.toString() +')"></div>' +
                              '<p class="name">' + contact.name + '</p>' +
                            '</li>'
                        );
                    });
                    $(".users-list-item").on("click", function(){
                        $(".chat-record *").remove();
                        $(".current").removeClass("current");
                        $(this).addClass("current");
                        var contactId = $(this).attr('data-id');
                        currentContact = contactId;
                        freshChatBox(contactId);
                    });

                    $("#send-msg").bind("keypress", function(ev) {
                        if (ev.keyCode == "13") {
                            var text = $(this).val();
                            sendMessage(text);
                        }
                    });
                    callback();
                }
            });
        } else {
            callback();
        }
    }

    function openChatBar(newsession, forceRefresh) {
        if (getCurrentUser() > 0) {
            if ($.isEmptyObject(messages) || forceRefresh == true) {
                $.ajax({
                    url: "/message/pull/",
                    method: "GET",
                }).success(function(resp) {
                    unReadCount = 0;
                    if (resp.status == true) {
                        if (newsession > 0) {
                            messages[newsession] = [];
                            currentContact = newsession;
                        }
                        handleNewMessages(resp.data);
                    }
                }).error(function(error) {
                    alert("网络异常");
                }).done(function() {
                    pullMessages();
                });
            }

            openBox = true;
            $("#chat-container").show(200);
        }
    }

    window.openChatBar = openChatBar;

    $("#message").click(function() {
        if (unReadCount > 0) {
            openChatBar(undefined, true);
        } else {
            openChatBar();
        }
    });

    $("#chat-close").click(function() {
        openBox = false;
        $("#chat-container").hide(200);
        pullAttention();
    });

    pullAttention();
});
