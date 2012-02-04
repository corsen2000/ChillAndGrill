class Rsvp < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  scope :yes, where(:status => 'Yes')
  scope :maybe, where(:status => 'Maybe')
  scope :no, where(:status => 'No')
end
