class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new # guest user (not logged in)
     # Admin
     if user.role? :admin
       can :manage, :all
       can :assign_roles, User
     else
       # Moderator
       if user.role? :moderator
         can :manage, Event
       end
       # Other
       can :read, :all
       can :create, User
       can :update, User, :id => user.id
       can :create, Registration, :user_id => user.id
       can :destroy, Registration, :user_id => user.id
     end
  end
end
