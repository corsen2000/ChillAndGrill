class RsvpsController < ApplicationController
  load_and_authorize_resource :event
  load_and_authorize_resource :rsvp, :through => :event

  def show
  end

  def new
    @title = "RSVP"
    unless params[:choose]
      @rsvp.user_id = current_user.id
    end
  end

  def edit
    @title = "Edit RSVP"
    session[:rsvp_edit_referer] = request.referer
  end

  def create
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
    if @rsvp.update_attributes(params[:rsvp])
      redirect_to session[:rsvp_edit_referer] || event_path(@rsvp.event)
    else
      redirect_to root_path, alert: 'Something went wrong...'
    end
    
  end
end