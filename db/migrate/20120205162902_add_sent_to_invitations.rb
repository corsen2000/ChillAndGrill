class AddSentToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :sent, :boolean, {:default => false}
  end
end
