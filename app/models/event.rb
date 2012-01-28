class Event < ActiveRecord::Base
  validates_presence_of :title, :description, :start
  has_many :registrations
  has_many :users, :through => :registrations
  scope :todays, lambda { where(:start => DateTime.now.beginning_of_day..DateTime.now.end_of_day) }
  scope :past, lambda { where("start < ?", DateTime.now.beginning_of_day) }
  scope :future, lambda { where("events.start > ?", DateTime.now.end_of_day) }
end
