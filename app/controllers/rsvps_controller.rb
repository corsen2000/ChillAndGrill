class RsvpsController < ApplicationController
  authorize_resource
  def create
    @event = Event.find(params[:event_id])
    @rsvp = @event.rsvps.build(:user => current_user)
    if @rsvp.save
      if request.referer == events_url
        redirect_to events_path, notice: 'rsvp successful.'
      else
        redirect_to event_path(@event), notice: 'rsvp successfull.'
      end
    else
      redirect_to events_path
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @rsvp = @event.rsvps.find(params[:id])
    @rsvp.destroy
    if request.referer == events_url
      redirect_to events_path, alert: 'Un-Registered'
    else
      redirect_to event_path(@event), alert: 'Un-Registered'
    end
  end
end
