class EventObserver < ActiveRecord::Observer
  def after_create(event)
  	do_notification(event)
  end

  def after_update(event)
  	do_notification(event)
  end

  def after_destroy(event)
    event.allowed_users.each do |user|
      Notification.un_notify user, event do
        UserMailer.cancelation_email(user, event).deliver
      end
    end
  end

  private
  def do_notification(event)
  	event.allowed_users.each do |user|
  		Notification.notify user, event do |notified|
  			UserMailer.invitation_email(user, event, !notified).deliver
  		end
  	end  	
  end
end
