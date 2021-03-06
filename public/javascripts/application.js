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
  
  $('.list-item .check-off').live("click", function(e){
    $(e.target).parents('.list-item').find('.list-item-body').toggleClass("checked-off");
    $(e.target).parents('form').submit();
  });

  $('.list-item .numbers.editable').live("click", function(e){
    $(e.target).parents('.list-item').find('.list-item-body').toggleClass("checked-off");
    var hidden_checkbox = $(e.target).parents('.list-item').find('form .check-off');
    $(hidden_checkbox).attr('checked', !$(hidden_checkbox).attr('checked')  );
    $(e.target).parents('.list-item').find('form').submit();
  });

  $('form#new_list_item').live("submit", function(e){
    e.preventDefault();
    if ($('#new-list-item-wrapper #list_item_body').val() === ''){
      return false;
    }
    $.post($(this).attr("action"), { list_item : { body : $('#new-list-item-wrapper #list_item_body').val() } }, function(data){
      $(".list-items").append(data);
      $('#new-list-item-wrapper  #list_item_body').val('').focus();
    });
  });
  
  $('.list-item-body-wrapper.editable .list-item-body-input input').live("blur", function(e){
    save_previously_edited();
  });
  
  $('.list-item-body-wrapper.editable').live("click", function(e){
    save_previously_edited();
    switch_to_editing_mode(this);
  });
  
  var switch_to_editing_mode = function(element){
    $(element).addClass("editing");
    $(element).find(".list-item-body-input input").focus();   
  }
  
  var save_previously_edited = function(){
    $('.list-item-body-wrapper.editing').each(function(index, element){
      var list_item_body = $(element).find(".list-item-body");
      var list_item_body_input = $(element).find(".list-item-body-input input");
      if( $(list_item_body).text() != $(list_item_body_input).val()){
        $(list_item_body).html($(list_item_body_input).val());
        var list_id = $(element).parents(".list-item").find("input.list-id").val();
        var list_item_id = $(element).parents(".list-item").find("input.list-item-id").val();
        var url = "/lists/" + list_id + "/list_items/" + list_item_id;
        $.ajax({ 
          url: url,
          type : "PUT", 
          data :  { list_item : { body : $(list_item_body_input).val() } }, 
          success :function(e){}
        });
      }
      $(element).removeClass("editing");
    });
  }

	$("label.inlined + input.form-textfield").each(function (type) {
			$(this).focus(function () {
				$(this).prev("label.inlined").addClass("focus");
			});

			$(this).keypress(function () {
				$(this).prev("label.inlined").addClass("has-text").removeClass("focus");
			});

			$(this).blur(function () {
				if($(this).val() == "") {
					$(this).prev("label.inlined").removeClass("has-text").removeClass("focus");
				}
			});
		});
})