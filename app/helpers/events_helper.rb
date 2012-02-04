module EventsHelper
  def format_date_time(date_time)
    date_time.strftime("%m/%d/%Y at %I:%M%p")
  end

  def get_rsvp_link(event)
    if registered? event
      link_to 'Un-Register', [event, get_rsvp(event)], confirm: 'Are you sure?', method: :delete
    else
      link_to 'Register', [event, event.rsvps.build], :method => :post
    end
  end

  def registered?(event)
    event.users.include? current_user
  end

  def get_rsvp(event)
    event.rsvps.where(:user_id => current_user)[0]
  end
end
