class UserMailer < ActionMailer::Base
  helper :events
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

  def reminder_email(users, event, have_rsvp = true)
    @event = event
    @have_rsvp = have_rsvp
    subject = (have_rsvp ? "Reminder" : "Missing RSVP") + " for #{event.title} at the Chill And Grill"
    mail(:to => ENV["CGMAILER_ACCOUNT"], :bcc => users.collect {|user| user.email}, :subject => subject)
  end
end
