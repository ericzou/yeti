class AppMailer < ActionMailer::Base
  default :from => "yetilistshare@gmail.com"
  
  def notification_to_admin_new_user_sign_up(user)
    @user = user
    mail :to => ADMIN_EMAILS, :subject => "MRVLST - #{Rails.env} - A new user just signed up!"
  end
  
  def invitation_to_share_list(invitation)
    @inviter = invitation.inviter
    @url_to_click = "#{YETI_URL}/?token=#{invitation.token}"
    mail :to => invitation.email, :subject => "#{@inviter.name} just shared a list with you on Yeti!"
  end
  
  def password_reset_instructions(user)
    subject      "Password Reset Instructions"
    from         "noreplay@marvellist.com"
    recipients   user.email
    content_type "text/html"
    sent_on      Time.now
    body         :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
end
