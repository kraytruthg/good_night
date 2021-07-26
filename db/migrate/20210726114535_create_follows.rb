class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :follower, foreign_key: { to_table: :users }
      t.references :followed_user, foreign_key: { to_table: :users }
      t.timestamps
    end

    add_index :follows, [:follower_id, :followed_user_id], unique: true
  end
end
