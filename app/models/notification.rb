class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def self.notify_user_for_event(user, event)
    notification = user.notifications.where(:event_id => event.id).first
    if notification
      notification.update_attribute(:sent_for_event_version, event.updated_at)
      UserMailer.invitation_email(user, event, false).deliver
    else
      create(:event_id => event.id, :user_id => user.id, :sent_for_event_version => event.updated_at)
      UserMailer.invitation_email(user, event, true).deliver
    end
  end
end
