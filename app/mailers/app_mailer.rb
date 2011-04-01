class AppMailer < ActionMailer::Base
  default :from => "yetilistshare@gmail.com"
  
  def notification_to_admin_new_user_sign_up(user)
    @user = user
    mail :to => ADMIN_EMAILS, :subject => "Yeti - #{Rails.env} - A new user just signed up!"
  end
  
  def invitation_to_share_list(invitation)
    @inviter = invitation.inviter
    @url_to_click = "#{YETI_URL}/?token=#{invitation.token}"
    mail :to => invitation.email, :subject => "#{@inviter.name} just shared a list with you on Yeti!"
  end
  
end
