class Event < ActiveRecord::Base
  validates_presence_of :title, :description, :start
  has_many :registrations
  has_many :users, :through => :registrations

  # Event.where('start BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)

end
