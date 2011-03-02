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
  
  def sort
    @list = List.find_by_id(params[:list_id])
    params[:list_item].each_with_index do | id, index |
      @list.list_items.update_all(["position=?", index+1], ["id=?", id])
    end
    respond_to do |format|
      format.js { render(:partial => @list.list_items) }
    end
  end

  def destroy
    @list_item = ListItem.find(params[:id])
    @list = @list_item.list
    @list_item.remove_from_list
    @list_item.destroy
    respond_to do |format|
      format.js { render :partial =>  @list.list_items }
    end  
  end
end
