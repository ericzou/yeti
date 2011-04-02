class LandingsController < ApplicationController
  def welcome
    session[:invitation_token] = params[:token]
    if current_user
      redirect_to home_user_path(current_user) and return 
    end
    @user = User.new
  end

end
