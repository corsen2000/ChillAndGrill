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
          can :manage, Rsvp
          can :send_invitations, Event
        end
        # Guest
        if user.role? :guest
          can :read, Rsvp, :user_id => user.id
          can [:create, :update], Rsvp do |rsvp|
            rsvp.event.start >= DateTime.now
          end
          can :read, Event do |event|            
            if event.is_private?
              event.invited_users.any? {|u| u == user}
            else
              true
            end
          end
        end
        # Other
        can :create, User
        can :update, User, :id => user.id
        can :show, User, :id => user.id
     end
  end
end