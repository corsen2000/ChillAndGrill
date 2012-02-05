class UserMailer < ActionMailer::Base
  default from: ENV["CGMAILER_ACCOUNT"]
  def welcome_email(user, login_url)
    @user = user
    @url = login_url
    mail(:to => user.email, :subject => "Welcome to Chill And Grill", :cc => ENV["CGMAILER_CC"])
  end
  def invitation_email(user, event)
    @user = user
    @event = event
    mail(:to => user.email, :subject => "Event Invitation", :cc => ENV["CGMAILER_CC"])
  end
end
