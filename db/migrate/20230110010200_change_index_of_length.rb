class ChangeIndexOfLength < ActiveRecord::Migration[7.0]
  def change
    add_index :sleeps, [:user_id, :start_at, :length]
    remove_index :sleeps, [:user_id, :start_at]
  end
end
