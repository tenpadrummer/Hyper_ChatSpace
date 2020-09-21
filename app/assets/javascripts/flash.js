$(function(){
  flash();
  var wrapper = $(".wrapper");

  function buildHTML(message){
    var html = `<div class='notification'>
                              <div class="notice">投稿に成功しました</div>
                            </div>`;
    return html;
  }

  function errorHTML(message){
    var html = `<div class='notification'>
                              <div class="alert">投稿に失敗しました</div>
                            </div>`;
    return html;
  }

  function flash(){
    setTimeout("$('.notification').fadeOut('slow')", 1000)
  }

  $("#new_message").on("submit", function(e){
      var count = $("#input-box__text").val().length;
      if (!count) {
        wrapper.before(errorHTML);
        flash();
      } else {
        wrapper.before(buildHTML);
        flash();
      }
  });
});
