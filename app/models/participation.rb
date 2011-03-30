class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  
  validates_presence_of :role, :message => "can't be blank"
  validates_uniqueness_of :user_id, :message => "user is already participating this list", :scope => :list_id
  
end
  
