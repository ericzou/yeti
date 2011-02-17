// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){

  var render_flash_msg = function(msg, theme) {
    $.jGrowl(msg, { theme: theme, life: 3000});
  };
  
  $('#flash_message .notice').livequery(function(){
    render_flash_msg($(this).text(), 'notice');
  });

  $('#flash_message .alert').livequery(function() {
    render_flash_msg($(this).text(), 'alert');
  });

  $('#flash_message .error').livequery(function() {
    render_flash_msg($(this).text(), 'error');
  });

  $('.submit').bind("click", function(e){
    e.preventDefault();
    if (!$(this).hasClass("disabled")){
      console.log("here");
      $(this).parents("form").find(".spinner").removeClass("hide");
      console.log(      $(this).parents("form").find(".spinner").html())
      $(this).addClass("disabled");
      $(this).parents("form").submit();
    }
  });
})