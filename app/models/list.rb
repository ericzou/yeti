class List < ActiveRecord::Base
  has_many :list_items, :order => "position"
  has_many :participations
  has_many :participants, :through => :participations, :source => :user
  
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  
  acts_as_taggable
  
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_presence_of :style, :on => :create, :message => "must choose a list style"
  
  accepts_nested_attributes_for :list_items
  
  validates_presence_of :list_items, :on => :create, :message => "can't be blank"
  
end
