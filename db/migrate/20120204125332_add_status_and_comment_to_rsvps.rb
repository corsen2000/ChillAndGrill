class AddStatusAndCommentToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :status, :string
    add_column :rsvps, :comment, :text
  end
end
