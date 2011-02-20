class List < ActiveRecord::Base
  has_many :list_items
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  
  acts_as_taggable
  
end
