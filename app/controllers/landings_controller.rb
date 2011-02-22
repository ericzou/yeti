class LandingsController < ApplicationController
  def welcome
    if current_user
      redirect_to home_user_path(current_user) and return 
    end
    @user = User.new
  end

end
