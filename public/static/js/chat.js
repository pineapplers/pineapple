$(function(){
    var messages = {};
    var contacts = {};
    var lastTime = 0;
    var openBox = false;
    var curerntContact = -1;
    var userId = -1;

    function getUserId() {
        $.ajax({
            url: "/user/whoami/",
            method: "GET",
        }).success(function(resp) {
            if (resp.status == true) {
                userId = resp.id;
            } else {
                getUserId();
            }
        });
    }

    getUserId();

    function getCurrentUser() {
        if (userId < 0) {
            alert('服务器错误');
        }
        return userId;
    }

    function recordAppend(side, msg) {
        $('.chat-record').append(
            '<div class="record-item ' + side +' clearfix">' +
              '<div class="record">' +
               msg +
              '</div>' +
            '</div>'
        );
    }

    function freshChatBox(contactId) {
        $(".chat-record *").remove();
        var msgs = messages[contactId];
        $(".chat-title").text(contacts[contactId]['name']);
        if (msgs) {
            msgs.forEach(function(msg, index) {
                var side = 'sender';
                if (msg.from == getCurrentUser()) {
                    side = 'receiver';
                }
                recordAppend(side, msg.msg);
            });
        }
    }

    function handleNewMessages(data, push) {
        if (data.length == 0)
            return
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
            if (msg.time > lastTime) {
                lastTime = msg.time;
            }
        });
        $(".char-record").last().focus();
        if (curerntContact > 0) {
            freshChatBox(curerntContact);
        }
        loadContacts();
    }

    function pullAttention() {
        $.ajax({
            url: "/message/attention/",
            method: "GET",
        }).success(function(resp) {
            var count = resp.count;
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
        if (curerntContact < 0) {
            alert('请选择联系人');
            return;
        }
        $.ajax({
            url: "/message/send/",
            method: "POST",
            data: {
                'msg': text,
                'user': curerntContact
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

    function loadContacts(user_ids) {
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
                        contacts[contact.user] = contact;
                        $(".chat-users").prepend(
                            '<li class="users-list-item clearfix" data-id=' + contact.user + '>' +
                              '<div class="portrait" background-image: url('+ contact.avatar +')"></div>' +
                              '<p class="name">' + contact.name + '</p>' +
                            '</li>'
                        );
                    });
                    $(".users-list-item").on("click", function(){
                        $(".chat-record *").remove();
                        $(".current").removeClass("current");
                        $(this).addClass("current");
                        var contactId = $(this).attr('data-id');
                        curerntContact = contactId;
                        freshChatBox(contactId);
                    });

                    $("#send-msg").bind("keypress", function(ev) {
                        if (ev.keyCode == "13") {
                            var text = $(this).val();
                            sendMessage(text);
                        }
                    });
                }
            });
        }
    }

    $("#message").click(function() {
        if ($.isEmptyObject(messages)) {
            $.ajax({
                url: "/message/pull",
                method: "GET",
            }).success(function(resp) {
                if (resp.status == true) {
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
    });

    $("#chat-close").click(function() {
        openBox = false;
        $("#chat-container").hide(200);
    });

    pullAttention();
});
