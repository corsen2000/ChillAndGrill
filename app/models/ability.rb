class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new # guest user (not logged in)
     # Admin
     if user.role? :admin
       can :manage, :all
       can :assign_roles, User
       can :send_invitations, Event
     else
        # Moderator        
        if user.role? :moderator
          can :manage, Event
          can :send_invitations, Event
        end
        # Guest
        if user.role? :guest
          can :manage, Rsvp, :user_id => user.id
          can :read, Event do |event|            
            event.can_come? user
          end          
        end
        # Other
        can :create, User
        can :update, User, :id => user.id
        can :show, User, :id => user.id
     end
  end
end
