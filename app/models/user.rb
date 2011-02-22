class User < ActiveRecord::Base
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  acts_as_authentic do |c|
    
  end # block optional
end
