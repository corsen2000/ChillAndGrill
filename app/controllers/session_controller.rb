class SessionController < ApplicationController
  force_ssl :only => [:new, :create]

  def new
    @title = "Sign In"
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:login_redirect].nil?
        redirect_to root_url(:protocol => "http")
      else
        redirect_to session[:login_redirect]
      end      
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
