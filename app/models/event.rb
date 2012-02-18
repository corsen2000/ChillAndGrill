class Event < ActiveRecord::Base  
  has_many :rsvps  
  has_many :users, :through => :rsvps
  has_many :invitations
  has_many :notifications
  has_many :invited_users, :through => :invitations, :source => :user

  validates_presence_of :title, :description, :start
  validate :event_cannot_be_made_private_after_invitations_sent, :on => :update

  scope :todays, lambda { where(:start => DateTime.now.beginning_of_day..DateTime.now.end_of_day).order("start") }
  scope :past, lambda { where("start < ?", DateTime.now.beginning_of_day).order("start DESC") }
  scope :future, lambda { where("events.start > ?", DateTime.now.end_of_day).order("start") }

  def rsvp_for_user(user)
    rsvps.where(:user_id => user).first
  end

  def can_come?(user)
    if self.private
      invited_users.any? {|u| u == user}
    else
      true
    end    
  end

  def un_notified_users
    invited_users = nil
    notified_users = notifications.where(:sent_for_event_version => updated_at).pluck(:user_id)
    if is_private?
      invited_users = invitations.pluck(:user_id)
    else
      invited_users = User.approved.pluck(:id)
    end
    invited_users - notified_users    
  end

  def un_notified_users?
    un_notified_users.any?
  end

  def is_private?
    self.private
  end

  def notify_users
    if un_notified_users?
      users_to_notify = un_notified_users
      users_to_notify.each do |user_id|
        user = User.find(user_id)
        Notification.notify_user_for_event(user, self)
      end
    end
    users_to_notify.length
  end

  def event_cannot_be_made_private_after_invitations_sent
    if is_private?
      unless notifications.empty?
        errors.add(:private, "can't be selected after public invitations have been sent")
      end
    end
  end
end
