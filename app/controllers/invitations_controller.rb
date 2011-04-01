class InvitationsController < ApplicationController
  
  def destroy
    @invitation = Invitation.find_by_id(params[:id])
    @invitation.destroy
    return render :nothing => true
  end
  
  def update
    @invitation = Invitation.find_by_id(params[:id])
    @invitation.update_attributes(params[:invitation])
    return render :nothing => true 
  end
end
