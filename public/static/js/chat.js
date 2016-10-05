$(function(){
    var data = null;
    var messages = {};
    var contacts = null;

    function loadContacts(messages) {
        if (contacts == null) {
            contacts = {};
            var user_ids = [];
            for (var id in messages) {
                user_ids.push(id);
            }
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
                        $(".chat-users").append(
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
                        var msgs = messages[contactId];
                        $(".chat-title").text(contacts[contactId]['name']);
                        if (msgs) {
                            msgs.forEach(function(msg, index) {
                                var side = msg.from == 1? 'sender': 'receiver';
                                $('.chat-record').append(
                                    '<div class="record-item ' + side +' clearfix">' +
                                      '<div class="record">' +
                                       msg.msg +
                                      '</div>' +
                                    '</div>'
                                );
                            });
                        }
                    });
                }
            });
        }
    }

    $("#message").click(function() {
        if (messages) {
            $.ajax({
                url: "/message/pull",
                method: "GET",
            }).success(function(resp) {
                if (resp.status == true) {
                    data = resp.data;
                    data.forEach(function(msg, index){
                        if (!messages.hasOwnProperty(msg.from)) {
                            messages[msg.from] = [];
                        }
                        messages[msg.from].push(msg);
                    });
                }
            }).error(function(error) {
                alert("网络异常");
            }).done(function(){
                loadContacts(messages);
            });
        }

        $("#chat-container").show(200);
    });

    $("#chat-close").click(function(){
        $("#chat-container").hide(200);
    });
});
