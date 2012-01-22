class EventsController < ApplicationController
  load_and_authorize_resource
  
  def index
  end

  def show
    @registration = @event.registrations.where(:user_id => current_user)[0]
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
end
