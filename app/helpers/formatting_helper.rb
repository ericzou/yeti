module FormattingHelper
        
  def page_title(page_title)
    content_for(:page_title) { page_title }
  end
  
  def body_id(body_id)
    content_for(:body_id) { body_id }
  end
  
  def body_class(body_class)
    content_for(:body_class) {body_class}
  end
  
  def sub_nav(sub_nav)
    content_for(:sub_nav) { render :partial => "layouts/navs/subnavs/#{sub_nav}" }
  end
    
end