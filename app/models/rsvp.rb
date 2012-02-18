class Rsvp < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user_id, :uniqueness => { :scope => :event_id, :message => "should only rsvp once for a event" }

  scope :yes, where(:status => 'Yes')
  scope :maybe, where(:status => 'Maybe')
  scope :no, where(:status => 'No')
end
