class User < ActiveRecord::Base
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  has_many :lists_as_creator, :class_name => "List", :foreign_key => "creator_id", :conditions => "state != 'deleted'"
  has_many :participations
  has_many :participating_lists, :through => :participations, :source => :list, :conditions => "lists.state != 'deleted'"
  
  acts_as_authentic do |c|
    
  end # block optional

  def creator_for_list?(list)
    self == list.creator
  end
  
  def editor_for_list?(list)
    list.editors.include?(self)
  end
  
  def viewer_for_list?(list)
    list.viewers.include?(self)
  end
  
  def can_view_list?(list)
    return true if list.public
    return true if viewer_for_list?(list) || editor_for_list?(list) || creator_for_list?(list)
    return false
  end
  
end
