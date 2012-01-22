class RegistrationsController < ApplicationController
  authorize_resource
  def create
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.build(:user => current_user)
    if @registration.save
      redirect_to event_path(@event), notice: 'Registration successfull.'
    else
      redirect_to events_path
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find(params[:id])
    @registration.destroy
    redirect_to event_path(@event), notice: 'Un-Registered'
  end
end
