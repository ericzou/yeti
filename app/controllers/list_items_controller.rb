class ListItemsController < ApplicationController
  
  def create
    @list = List.find_by_id(params[:list_id])
    @list_item = @list.list_items.build(params[:list_item].merge({
      :creator => current_user
    }))
    
    respond_to do |format|
      if @list_item.save
        format.js { render :partial => "list_item", :locals => { :list_item => @list_item } }
      else
        format.js do
          flash[:error] = "Please enter something"
          # render something here
        end 
      end
    end
  end
end
