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
