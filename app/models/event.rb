class Event < ActiveRecord::Base  
  has_many :rsvps  
  has_many :users, :through => :rsvps
  has_many :invitations
  has_many :notifications
  has_many :invited_users, :through => :invitations, :source => :user

  validates_presence_of :title, :description, :start
  validate :event_cannot_be_made_private, :on => :update

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

  def event_cannot_be_made_private
    if private_changed? && is_private?
      errors.add(:private, "can only be selected on event creation")
    end
  end

  def invited_user_ids_with_guard=(ids)
    self.invited_user_ids_without_guard = self.invited_user_ids.concat(ids).uniq
  end
  alias_method_chain :invited_user_ids=, :guard
end
