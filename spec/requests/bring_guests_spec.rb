require 'spec_helper'

def login(user)
  visit new_session_path
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => user.password
  click_button 'Log in'  
end

describe "BringGuests" do
  it "allows the user to bring guests" do
    event = Factory.create(:event, :start => DateTime.now + 1.days)
    user = Factory.create(:user, :first_name => "Bryan", :roles => ["guest"])
    login user
    visit new_event_rsvp_path(event)
    page.select 'Yes', :from => 'rsvp_status'
    page.select '3', :from => 'rsvp_guests'
    click_button 'RSVP'
    visit event_path(event)
    page.should have_content('Attending This Event (4)')
    page.should have_content('Bryan +3')
  end
end