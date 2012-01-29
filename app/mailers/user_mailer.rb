class UserMailer < ActionMailer::Base
  default from: ENV["CGMAILER_ACCOUNT"]
  def welcome_email(user, login_url)
    @user = user
    @url = login_url
    mail(:to => user.email, :subject => "Welcome to Chill And Grill", :cc => ENV["CGMAILER_CC"])
  end
end
