class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def self.notify(user, event)
    notification = user.notifications.where(:event_id => event.id).first
    unless notification && notification.sent_for_event_version == event.updated_at
      yield !!notification
      if notification
        notification.update_attribute(:sent_for_event_version, event.updated_at)
      else
        create(:event_id => event.id, :user_id => user.id, :sent_for_event_version => event.updated_at)
      end
    end
  end

  def self.un_notify(user, event)
    notification = user.notifications.where(:event_id => event.id).first
    yield
    notification.destroy if notification
  end
end
