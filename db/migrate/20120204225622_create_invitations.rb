class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
    add_index :invitations, :user_id
    add_index :invitations, :event_id
  end
end
