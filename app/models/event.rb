class Event < ActiveRecord::Base
  validates_presence_of :title, :description, :start
  has_many :rsvps  
  has_many :users, :through => :rsvps
  has_many :invitations
  has_many :invited_users, :through => :invitations, :source => :user

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

  def unsent_invitations?
    invitations.where(:sent => false).exists?
  end
end
