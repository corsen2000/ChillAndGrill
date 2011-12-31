class Event < ActiveRecord::Base
  validates_presence_of :title, :description, :start
end
