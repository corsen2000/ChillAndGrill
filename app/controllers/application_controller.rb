class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_protocol

  include SessionHelper

  rescue_from CanCan::AccessDenied do
    flash[:error] = "Access Denied!"
    redirect_to root_url
  end  

  def ensure_protocol  	
  	if request.ssl? && !(self.class.read_inheritable_attribute(:force_ssl) || []).include?(action_name.to_sym)
  		flash.keep
  		redirect_to "http://" + request.host + request.request_uri
  	end
  end
end
