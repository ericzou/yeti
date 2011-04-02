class Invitation < ActiveRecord::Base
  belongs_to :list, :class_name => "List", :foreign_key => "list_id"
  belongs_to :inviter, :class_name => "User", :foreign_key => "inviter_id"
  
  scope :pending, lambda { where("invitations.state = 'pending' " ) }
  scope :accepted, lambda { where("invitations.state = 'accepted' " ) }
  def self.generate_token
    Digest::SHA1.hexdigest([Time.now, rand].join)
  end
  
  def self.accept_all_invitations_shared_with!(user, token=nil)
    invitations = []
    invitations << Invitation.pending.find_all_by_email(user.email)
    invitations << Invitation.pending.find_by_token(token) if token
    invitations.flatten.uniq.each do |invitation|
      Participation.create(:list => invitation.list, :user => user, :role => invitation.role)
      invitation.accept!
    end
  end
  
  def accept!
    update_attribute(:state, "accepted")
  end
  
  def after_create
    self.update_attribute(:token, Invitation.generate_token)
    AppMailer.invitation_to_share_list(self).deliver
  end
end
