class ListItem < ActiveRecord::Base
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  belongs_to :list
  acts_as_list :scope => :list
    
  validates_presence_of :body, :on => :create, :message => "can't be blank"
end
