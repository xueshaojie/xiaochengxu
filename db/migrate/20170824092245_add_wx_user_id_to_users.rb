class AddWxUserIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :wx_user_id, :integer
  end
end
