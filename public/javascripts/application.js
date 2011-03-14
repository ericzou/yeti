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

    clone_list_item : function(list_item){
      var n = $(list_item).find(".list-style.numbers").html();
      var m = n - 1;
      var linked_clone_id = "list_list_items_attributes_" + m + "_body"
      var linked_clone_name = "list[list_items_attributes][" + m + "][body]"
      linked_clone = $("#list_items").append("<input class='target' id='" + linked_clone_id +  
      "' name='" + linked_clone_name + "' type='hidden' value=''>");

      $(list_item).find(".list-item-input input").attr("id", linked_clone_id+"_source");
      
      the_clone = $(list_item).clone().insertAfter($(list_item));
      
      // var new_id = $(list_item).attr("id").gsub(/_(\d+)/, \1+1)
      $(list_item).removeClass("last");
      $(the_clone).addClass("last");
      // console.log($(the_clone).find(".list-item-input input").attr("id"));
      $(the_clone).find(".list-item-input").hide();
      $(the_clone).find(".list-item-body").show();
      if ( $(list_item).find(".list-style.numbers").val() !== undefined ){
        $(the_clone).find(".list-style.numbers").html( parseInt(n) + 1);
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