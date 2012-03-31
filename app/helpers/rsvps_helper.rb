module RsvpsHelper
  def get_guests(rsvp)
    number_of_guests = rsvp.guests
    number_of_guests == 0 ? "" : "+#{number_of_guests}"
  end
end
