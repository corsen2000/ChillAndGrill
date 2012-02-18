class PagesController < ApplicationController
  def home
    @title = "Home"
    if can? :read, Event
      flash.keep
      redirect_to events_path
    end
  end

  def about
    @title = "About"
  end
end