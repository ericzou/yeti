module ApplicationHelper
  
  def left_panel_nav(selected="my-lists")
    content_for :left_panel_nav do 
      html = ""
      if current_user 
        html << content_tag(:li, :class=>"my-lists #{selected == "my-lists" ? "selected" : "" }") do
          link_to "My Lists", home_user_path(current_user)
        end
        
        html << content_tag(:li, :class=>"create-new-list #{selected == "create-new-list" ? "selected" : "" }") do
          link_to "Create New List", new_list_path
        end
        
        html << content_tag(:li, :class=>"browse #{selected == "browse" ? "selected" : "" }") do
          link_to "Browse", browse_lists_path
        end
      end
      html.html_safe
    end
  end
    
  def floating_explanation(obj, attribute, msg)
    err = obj.errors[attribute].any? ? true : false
    html = content_tag(:div, :class=>"floating-explanation title #{ err ? 'wrong' : '' }") do       
      if err
        m = attribute.to_s.titleize + " " + obj.errors[attribute][0]
      else
        m = msg
      end
      "<span class='yellow-tip'></span>#{m}".html_safe  
    end
  end
  
end
