class RemoveSentFromInvitations < ActiveRecord::Migration
  def change
    remove_column :invitations, :sent
  end
end
