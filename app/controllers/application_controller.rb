class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionHelper

  rescue_from CanCan::AccessDenied do
  	if signed_in?
    	flash[:error] = "Access Denied!"
    	redirect_to root_url
  	else
  		session[:login_redirect] = request.url
  		redirect_to new_session_url
  	end
  end  

end
