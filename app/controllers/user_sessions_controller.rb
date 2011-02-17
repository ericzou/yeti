class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default home_user_path(User.first)
    else
      flash[:error] = "Login error, please try again."
      # puts "******", @user_session.errors.full_messages.to_sentence
      render :template => "landings/welcome"
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to landings_welcome_path
  end
end
