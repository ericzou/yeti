class LandingsController < ApplicationController
  def welcome
    @user = User.new
  end

end
