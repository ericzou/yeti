class ParticipationsController < ApplicationController
  def create
    
  end
  
  def new
    
  end
  
  def destroy
    @participation = Participation.find_by_id(params[:id])
    @participation.destroy
    return render :nothing => true
  end
  
  def index
    
  end
  
  def show
    
  end
  
  # {"participation"=>{"role"=>"viewer"}, "authenticity_token"=>"ouPriOfMUkogu4Abz1PjPgIjJhI9XdX4Rp4BFkFSs+8=",
  #  "utf8"=>"\342\234\223", "id"=>"8"}
  def update
    @participation = Participation.find_by_id(params[:id])
    @participation.update_attributes(params[:participation])
    return render :nothing => true 
  end
end
