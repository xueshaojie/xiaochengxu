class CreateWxUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :wx_users do |t|
      t.integer  "user_id"
      t.integer  "status",                  :default => 1,     :null => false
      t.string   "openid",                                     :null => false
      t.string   "nickName"
      t.integer  "gender",                     :default => 0
      t.string   "language"
      t.string   "city"
      t.string   "province"
      t.string   "country"
      t.string   "avatarUrl"
      t.string   "unionid"
      t.string   "remark"
      t.string   "location_x"
      t.string   "location_y"
      t.string   "location_label"
      t.string   "session_key"
      t.string   "unionid"

      t.timestamps
    end
  end
end
