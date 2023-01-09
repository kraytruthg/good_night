class AddLengthToSleeps < ActiveRecord::Migration[6.1]
  def change
    add_column :sleeps, :length, :integer, as: "TIMESTAMPDIFF(SECOND, start_at, end_at)", after: :end_at
    add_index :sleeps, [:user_id, :start_at]
    remove_index :sleeps, :user_id
  end
end
