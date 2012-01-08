class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionHelper

  rescue_from CanCan::AccessDenied do
    flash[:error] = "Access denied."
    redirect_to root_url
  end  
end
