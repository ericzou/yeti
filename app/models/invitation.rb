class Invitation < ActiveRecord::Base
  belongs_to :list, :class_name => "List", :foreign_key => "list_id"
  belongs_to :inviter, :class_name => "User", :foreign_key => "inviter_id"
  
  def self.generate_token
    Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def after_create
    logger.info("**********")
    puts "1"
    self.update_attribute(:token, Invitation.generate_token)
    puts "2"
    AppMailer.invitation_to_share_list(self).deliver
    puts "3"
  end
end
