class RegistrationsController < ApplicationController
  authorize_resource
  def create
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build(:user => current_user)
    if @registration.save
      if request.referer == events_url
        redirect_to events_path, notice: 'Registration successful.'
      else
        redirect_to event_path(@event), notice: 'Registration successfull.'
      end
    else
      redirect_to events_path
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find(params[:id])
    @registration.destroy
    if request.referer == events_url
      redirect_to events_path, notice: 'Un-Registered'
    else
      redirect_to event_path(@event), notice: 'Un-Registered'
    end
  end
end
