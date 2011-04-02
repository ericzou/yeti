class User < ActiveRecord::Base
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  has_many :lists_as_creator, :class_name => "List", :foreign_key => "creator_id"
  has_many :participations
  has_many :participating_lists, :through => :participations, :source => :list
  
  acts_as_authentic do |c|
    
  end # block optional

end
