module ApplicationHelper
  
  def left_panel_nav(selected="my-lists")
    content_for :left_panel_nav do 
      html = ""
      if current_user 
        html << content_tag(:li, :class=>"my-lists #{selected == "my-lists" ? "selected" : "" }") do
          link_to "My Lists", home_user_path(current_user)
        end
        
        html << content_tag(:li, :class=>"#create-new-list #{selected == "create-new-list" ? "selected" : "" }") do
          link_to "Create New List", new_list_path
        end
      end
      html
    end
  end
  
end
