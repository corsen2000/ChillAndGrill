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
        # Guest
        if user.role? :guest
          can :read, :all
          can :manage, Rsvp, :user_id => user.id
        end
        # Other
        can :create, User
        can :update, User, :id => user.id
     end
  end
end
