class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.references :event
      t.timestamp :sent_for_event_version

      t.timestamps
    end
    add_index :notifications, :user_id
    add_index :notifications, :event_id
  end
end
