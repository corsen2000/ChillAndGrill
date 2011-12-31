module SessionHelper
  
  def current_user
    @current_user ||= User.authenticate(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user ? true : false
  end

end
