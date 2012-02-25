class Event < ActiveRecord::Base  
  has_many :rsvps  
  has_many :users, :through => :rsvps
  has_many :invitations
  has_many :notifications
  has_many :invited_users, :through => :invitations, :source => :user
  has_many :notified_users, :through => :notifications, :source => :user
  has_many :well_notified_users, :through => :notifications, :source => :user, :conditions => proc { {"notifications.sent_for_event_version" => updated_at} }

  validates_presence_of :title, :description, :start
  validate :event_cannot_be_made_private_after_invitations_sent, :on => :update
  validate :notified_users_cannot_be_uninvited, :on => :update

  scope :todays, lambda { where(:start => DateTime.now.beginning_of_day..DateTime.now.end_of_day).order("start") }
  scope :past, lambda { where("start < ?", DateTime.now.beginning_of_day).order("start DESC") }
  scope :future, lambda { where("events.start > ?", DateTime.now.end_of_day).order("start") }

  def rsvp_for_user(user)
    rsvps.where(:user_id => user).first
  end

  def allowed_users
    if is_private?
      invited_users
    else
      User.approved
    end
  end

  def is_private?
    self.private
  end

  def event_cannot_be_made_private_after_invitations_sent
    if private_changed? && is_private?
      unless notifications.empty?
        errors.add(:private, "can't be selected after public invitations have been sent")
      end
    end
  end

  def notified_users_cannot_be_uninvited
    if is_private?
      uninvited_users = (notified_users - invited_users).collect {|u| u.first_name}
      unless uninvited_users.empty?
        errors[:base] << "The following can't be uninvited because they already recieved invitations: #{uninvited_users.join(", ")}"
      end
    end
  end
end
