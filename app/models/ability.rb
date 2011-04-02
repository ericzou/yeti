class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
    # user 
    #   can do everthing to the lists he owns 
    #   can do everthing to the lists he as editor except deleting it
    #   can only read to the lists he as viewer
    
    # create list
    # read list
    # update list
    # destroy list
    # create participation
    # read participation
    # update participation
    # destroy participation
    # create list item
    # read list item
    # update list item
    # destroy list item
    
    can :manage, List, :creator_id => user.id 
    can [:read, :update], List do |list|
      list.editors.include?(user)
    end 
    can [:read], List do |list|
      list.viewers.include?(user) || list.public?
    end

    can :manage, Participation do |participation|
      participation.list.creator == user || participation.list.editors.include?(user)
    end
    can [:read], Participation do |participation|
      participation.list.viewers.include?(user) 
    end
    
    can :manage, ListItem do |list_item|
      list_item.list.creator == user || list_item.list.editor.include?(user)
    end
    can [:read], ListItem do |list_item|
      list_item.list.viewers.include?(user) || list_item.list.public?
    end
    
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
