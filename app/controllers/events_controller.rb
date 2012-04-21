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
      redirect_to @event
    else
      render action: "new"
    end
  end

  def update
    if params[:quiet_update]
      Event.observers.disable :all do
        perform_update  
      end
    else
      perform_update
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url
  end

  def remind  
    have_rsvp = @event.rsvps.yes + @event.rsvps.maybe
    have_rsvp = have_rsvp.collect {|rsvp| User.find(rsvp.user_id)}
    UserMailer.reminder_email(have_rsvp, @event).deliver if have_rsvp.length > 0
    UserMailer.reminder_email(@event.no_rsvp, @event, false).deliver if @event.no_rsvp.length > 0
    redirect_to request.referer
  end

  private
  def perform_update
    params[:event][:invited_user_ids] ||= []
    if @event.update_attributes(params[:event])
      redirect_to @event
    else
      render action: "edit"
    end
  end
end
