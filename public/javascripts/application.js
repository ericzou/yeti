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
    }, 

    add_list_item : function(i, body, style){
      var list_item_id = "list_list_items_attributes_" + (i-1) + "_body_source";
      var a = $("<li class='list-item'>")
        .append("<span class='list-style " + style + "'>" + i + "</span>")
        .append("<span class='list-item-body show-inline' id='"+ list_item_id + "'>" + body + "</span>");
      return a;
    },
    
    add_linked_list_item : function(i, body, style){
      var list_item_id = "list_list_items_attributes_" + (i-1); 
      var dom = $("<input class='target' id='"+ list_item_id +"' name='list[list_items_attributes]["+ (i-1) +"][body]' type='hidden'/>");
      $(dom).val(body);
      return dom;
    }, 
    
    click_list_title_to_load_detail : function(){
      $('.list:not(.blank-state)').click(function(e){
        e.preventDefault();
        list_id = $(this).attr("id").split("_")[1];
        $.ajax({
          url : "/lists/" + list_id,
          type: "get",
          dataType: "html",
          success : function(data){
            $('#list-detail').html(data);
          }
        });
      });
    },
    
    fire_cloud_poof : function(){
      var i = 0;
      c = setInterval(function(){
        $('.cloud-poof, #cloud-poof').css("background-position-x", -90*i + 'px');        
        i++;
        if ( i > 4){
          clearInterval(c);
        }
      }, 150);
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