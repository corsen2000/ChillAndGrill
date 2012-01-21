class RegistrationsController < ApplicationController
  def create
    @registration = Registration.new(params[:registration])
    if @registration.save
      redirect_to root_path, notice: 'Registration successfull.'
    else
      redirect_to events_path
    end
  end

  def destroy

  end
end
