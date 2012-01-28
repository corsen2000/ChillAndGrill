class Event < ActiveRecord::Base
  validates_presence_of :title, :description, :start
  has_many :registrations
  has_many :users, :through => :registrations
  scope :todays, where(:start => DateTime.now.beginning_of_day..DateTime.now.end_of_day)
  scope :past, where("start < ?", DateTime.now.beginning_of_day)
  scope :future, where("events.start > ?", DateTime.now.end_of_day)
end
