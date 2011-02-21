// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  
  Yeti = {
    render_flash_msg : function(msg, theme) {
      $.jGrowl(msg, { theme: theme, life: 3000});
    }, 
    
    isEmpty : function(v){
      if( v === null ){
        return true;
      }else if( v === []){
        return true;
      }else if( v === ""){
        return true;
      }else if( v.replace(/ /g, "") === ""){
        return true;
      }else{
        return false;
      }
    }
  }
  
  $('#flash_message .notice').livequery(function(){
    Yeti.render_flash_msg($(this).text(), 'notice');
  });

  $('#flash_message .alert').livequery(function() {
    Yeti.render_flash_msg($(this).text(), 'alert');
  });

  $('#flash_message .error').livequery(function() {
    Yeti.render_flash_msg($(this).text(), 'error');
  });

  $('.submit').bind("click", function(e){
    e.preventDefault();
    if (!$(this).hasClass("disabled")){
      $(this).parents("form").find(".spinner").removeClass("hide");
      $(this).addClass("disabled");
      $(this).parents("form").submit();
    }
  });
})