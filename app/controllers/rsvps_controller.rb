class RsvpsController < ApplicationController
  authorize_resource

  def show
    @rsvp = Rsvp.find(params[:id])
  end

  def new
    @title = "RSVP"
    @event = Event.find(params[:event_id])
    @rsvp = @event.rsvps.build
  end

  def edit
    @title = "Edit RSVP"
    @event = Event.find(params[:event_id])
    @rsvp = Rsvp.find(params[:id])
    session[:rsvp_edit_referer] = request.referer
  end

  def create
    @event = Event.find(params[:event_id])
    @rsvp = @event.rsvps.build(params[:rsvp])
    @rsvp.user = current_user
    if @rsvp.save
      if request.referer == events_url
        redirect_to events_path
      else
        redirect_to event_path(@event)
      end
    else
      redirect_to events_path, alert: "Unable to rsvp for this event"
    end
  end

  def update
    @rsvp = Rsvp.find(params[:id])
    if @rsvp.update_attributes(params[:rsvp])
      redirect_to session[:rsvp_edit_referer]
    else
      redirect_to root_path, alert: 'Something went wrong...'
    end
    
  end
end