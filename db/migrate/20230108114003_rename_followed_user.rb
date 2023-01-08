class RenameFollowedUser < ActiveRecord::Migration[6.1]
  def change
    rename_column :follows, :followed_user_id, :following_id
  end
end
