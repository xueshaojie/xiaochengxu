class RemoveUserIdFromWxUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :wx_users, :user_id, :integer
  end
end
