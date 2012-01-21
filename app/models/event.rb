class Event < ActiveRecord::Base
  validates_presence_of :title, :description, :start
  has_many :registrations
  has_many :users, :through => :registrations
end
