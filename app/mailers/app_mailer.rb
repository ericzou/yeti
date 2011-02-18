class AppMailer < ActionMailer::Base
  default :from => "yetilistshare@gmail.com"
  
  def notification_to_admin_new_user_sign_up(user)
    @user = user
    mail :to => ADMIN_EMAILS, :subject => "Yeti - #{Rails.env} - A new user just signed up!"
  end
  
end
