module EventsHelper
  def format_date_time(date_time)
    date_time.strftime("%m/%d/%Y at %I:%M%p")
  end

  def get_rsvp_link(event)
    if registered? event
      rsvp = get_rsvp(event)      
      link_to "Edit RSVP (#{rsvp.status})", edit_event_rsvp_path(event, rsvp)
    else
      link_to 'RSVP', new_event_rsvp_path(event)
    end
  end

  def registered?(event)
    event.users.include? current_user
  end

  def get_rsvp(event)
    event.rsvps.where(:user_id => current_user)[0]
  end

  def get_view_rsvp_link(user, event)
    rsvp = user.rsvps.where(:event_id => @event.id).first
    if user == current_user
      link_to 'Edit RSVP', edit_event_rsvp_path(event, rsvp)
    else
      link_to 'View RSVP', event_rsvp_path(event, rsvp)
    end
  end

  def user_has_rsvp(event)
    event.rsvps.any? do |r|
      r.user_id == current_user.id
    end
  end
end
