class UserMailer < ActionMailer::Base
  default from: ENV["CGMAILER_ACCOUNT"]
  
  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Chill And Grill", :cc => ENV["CGMAILER_CC"])
  end

  def invitation_email(user, event, new_invitation = true)
    @user = user
    @event = event
    subject = "Event Invitation"
    subject += " (Update!)" unless new_invitation
    mail(:to => user.email, :subject => subject, :cc => ENV["CGMAILER_CC"])
  end

  def cancelation_email(user, event)
    @event = event
    mail(:to => user.email, :subject => "Event Canceled", :cc => ENV["CGMAILER_CC"])
  end

  def approval_email(user)    
    @user = user
    mail(:to => user.email, :subject => "Registration Approved At Chill And Grill", :cc => ENV["CGMAILER_CC"])
  end
end
