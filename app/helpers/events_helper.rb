module EventsHelper
  def format_date_time(date_time)
    date_time.strftime("%m/%d/%Y at %I:%M%p")
  end

  def registered?(event)
    event.users.include? current_user
  end

  def get_registration(event)
    event.registrations.where(:user_id => current_user)[0]
  end
end
