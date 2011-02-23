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
      var n = $(list_item).find(".list-style.numbered").html();
      var m = n - 1;
      var linked_clone_id = "list_list_items_attributes_" + m + "_body"
      var linked_clone_name = "list[list_items_attributes][" + m + "][body]"
      linked_clone = $("#list_items").append("<input class='target' id='" + linked_clone_id +  
      "' name='" + linked_clone_name + "' type='hidden' value=''>");

      $(list_item).find(".list-item-input input").attr("id", linked_clone_id+"_source");
      
      the_clone = $(list_item).clone().insertAfter($(list_item));
      
      $('.list-item.second-to-last').removeClass("second-to-last");
      $(list_item).addClass("second-to-last");
      // var new_id = $(list_item).attr("id").gsub(/_(\d+)/, \1+1)
      $(list_item).removeClass("last");
      $(the_clone).addClass("last");
      console.log($(the_clone).find(".list-item-input input").attr("id"));
      $(the_clone).find(".list-item-input").hide();
      $(the_clone).find(".list-item-body").show();
      if ( $(list_item).find(".list-style.numbered").val() !== undefined ){
        $(the_clone).find(".list-style.numbered").html( parseInt(n) + 1);
      } 
    }
     
    // create_list_item: function(n){
    //       var t = ( n === null ? "bulleted" : "numbered" );
    //       str = "<li class=" + "'list-item'> " 
    //               + "<span class=" + "'list-style numbered'>"  + "4" + "</span>"
    //               + "<span class=" + "'list-item-input'>"
    //                   + "<input type='textfield', class='form-textfield very-long short-height'>"
    //                 +"</span>"
    //       <span class="list-item-body"></span>
    //     </li>"
    //     }
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