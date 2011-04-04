class List < ActiveRecord::Base
  has_many :list_items, :order => "position", :dependent => :destroy
  has_many :participations, :dependent => :destroy
  has_many :participants, :through => :participations, :source => :user
  has_many :editors, :through => :participations, :source => :user, :conditions => { :participations => { :role => ROLES[:editor] } }
  has_many :viewers, :through => :participations, :source => :user, :conditions => { :participations => { :role => ROLES[:viewer] } }
  has_many :invitations, :dependent => :destroy
  
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
  
  scope :active, lambda{
    where("lists.state != ?", 'deleted')
  }
  scope :public, lambda { 
    where("lists.public is true")
  }
  
  scope :recent, lambda{
    order("lists.created_at desc")
  }
  
  acts_as_taggable
  
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_presence_of :style, :on => :create, :message => "must choose a list style"
  
  accepts_nested_attributes_for :list_items
  
  validates_presence_of :list_items, :on => :create, :message => "can't be blank"
  
  def add_editor!(user)
    participations.create!(:user => user, :role => ROLES[:editor] )
  end

  def add_viewer!(user)
    participations.create!(:user => user, :role => ROLES[:viewer] )
  end
  
end
