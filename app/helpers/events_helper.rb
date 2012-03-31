module EventsHelper
  def format_date_time(date_time, sentence = false)
    if sentence
      "Starts at #{date_time.strftime("%I:%M %p")} on #{date_time.strftime("%m/%d/%Y")}"
    else
      date_time.strftime("%m/%d/%Y at %I:%M %p")
    end    
  end

  def get_rsvp_link(event)
    if registered?(event)
      rsvp = get_rsvp(event)      
      link_to "Edit RSVP (#{rsvp.status})", edit_event_rsvp_path(event, rsvp) if can? :update, rsvp
    else
      link_to 'RSVP', new_event_rsvp_path(event) if can? :create, Rsvp
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

  def get_total_yes(event)
    total = Rsvp.total_yes event
    total == 0 ? "" : total
  end

  def get_total_maybe(event)
    total = Rsvp.total_maybe event
    total == 0 ? "" : total
  end

  def user_select_checkbox(event, user)
    already_invited = event.invited_users.include? user
    (check_box_tag :invited_user_ids, user.id, already_invited, :name => 'event[invited_user_ids][]', :id => "inv_box_#{user.id}", :disabled => already_invited) +
    (label_tag :invited_user_ids, user.first_name, {:for => "inv_box_#{user.id}", :class => "checkbox_label"})
  end
end
