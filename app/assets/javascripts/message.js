$(function(){
  function buildHTML(message){
    var image = message.image ? `<img src="${message.image}">` : "";
    var html = `<div class="message" data-message-id="${message.id}">
                  <div class="message__upper-info">
                    <div class="message__upper-info__user">
                      ${message.user_name}
                    </div>
                    <div class="message__upper-info__date">
                      ${message.date}
                    </div>
                  </div>
                  <div class="message__text">
                    <p class="lower-message__content">
                      ${message.content}
                    </p>
                    ${image}
                  </div>
                </div>`;
    return html;
  }

  $("#new_message").on("submit", function(e){
    e.preventDefault();
    var fd = new FormData(this);
    var href = window.location.href + '';
    $.ajax({
      url: href,
      type: "POST",
      data: fd,
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.messages').append(html);
      $('.new-message__submit-btn').attr('disabled', false);
      $('.input-box__text').val("");
      $('#new_message')[0].reset();
      $('.messages').animate({ scrollTop: $(".messages")[0].scrollHeight }, "first");
    })
    .fail(function(){
      alert("メッセージを送信できませんでした");
    })
  });

  var reloadMessages = function() {
    if (window.location.href.match(/\/groups\/\d+\/messages/)) {
      var last_message_id =$(".message:last").data("id");
      $.ajax({
        url: "api/messages",
        type: 'get',
        dataType: 'json',
        data: {last_id: last_message_id}
      })
      .done(function(messages) {
        var insertHTML = '';
        messages.forEach(function(message){
          inserHTML = buildHTML(message);
          $(".messages").append(insertHTML);
        })
        $(".messages").animate({ scrollTop: $(".messages")[0].scrollHeight }, "first");
      })
      .fail(function() {
        console.log("error");
      });
    }
  };
  setInterval(reloadMessages, 10000);
});