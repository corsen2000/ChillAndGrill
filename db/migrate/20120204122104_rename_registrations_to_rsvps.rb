class RenameRegistrationsToRsvps < ActiveRecord::Migration
  def change
    rename_table :registrations, :rsvps
  end
end
