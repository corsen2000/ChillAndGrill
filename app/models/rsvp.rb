class Rsvp < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user_id, :uniqueness => { :scope => :event_id, :message => "should only rsvp once for a event" }

  scope :yes, where(:status => 'Yes')
  scope :maybe, where(:status => 'Maybe')
  scope :no, where(:status => 'No')

  def self.total_yes(event)
    event.rsvps.yes.sum('guests') + event.rsvps.yes.length
  end

  def self.total_maybe(event)
    event.rsvps.maybe.sum('guests') + event.rsvps.maybe.length
  end
end
