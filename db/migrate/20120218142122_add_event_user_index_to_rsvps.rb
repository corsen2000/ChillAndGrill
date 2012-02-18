class AddEventUserIndexToRsvps < ActiveRecord::Migration
  def change
    add_index :rsvps, [ :event_id, :user_id ], :unique => true, :name => 'by_event_and_user'
  end
end
