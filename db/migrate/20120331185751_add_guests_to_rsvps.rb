class AddGuestsToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :guests, :integer, :default => 0
  end
end
