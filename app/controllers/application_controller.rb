class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionHelper

  rescue_from CanCan::AccessDenied do
    flash[:error] = "Access Denied!"
    redirect_to root_url
  end  

  def default_url_options(options = nil)
    {:protocol => "http"}
  end

end
