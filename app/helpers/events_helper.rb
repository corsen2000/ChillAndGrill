module EventsHelper
  def format_date_time(date_time, sentence = false)
    if sentence
      "Starts at #{date_time.strftime("%I:%M%p")} on #{date_time.strftime("%m/%d/%Y")}"
    else
      date_time.strftime("%m/%d/%Y at %I:%M%p")
    end    
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

  def user_has_rsvp(event)
    event.rsvps.any? do |r|
      r.user_id == current_user.id
    end
  end
end
