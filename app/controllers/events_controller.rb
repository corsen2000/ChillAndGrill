class EventsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => :index
  
  def index
    @todays_events = Event.todays.select {|event| can?(:read, event)}
    @future_events = Event.future.select {|event| can?(:read, event)}
    @past_events = Event.past.select {|event| can?(:read, event)}
  end

  def show
    @rsvp = @event.rsvps.where(:user_id => current_user)[0]
  end

  def new
  end

  def edit
  end

  def create
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    params[:event][:invited_user_ids] ||= []
    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url
  end

  def send_invitations    
    event = Event.find(params[:id])
    authorize! :send_invitations, event
    invitations = event.invitations.where(:sent => false)
    invitations.each do |inv|
      UserMailer.invitation_email(inv.user, event).deliver
      inv.update_attribute(:sent, true)
    end
    flash[:notice] = "We sent #{invitations.length} emails!"    
    redirect_to event_path(event)
  end
end
