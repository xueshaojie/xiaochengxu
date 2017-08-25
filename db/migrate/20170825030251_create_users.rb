class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string   "name"
      t.string   "email"
      t.integer  "wx_user_id"
      t.datetime "created_at",                        null: false
      t.datetime "updated_at",                        null: false
      t.string   "password_digest"
      t.string   "remember_digest"
      t.string   "activation_digest"
      t.string   "reset_digest"
      t.datetime "reset_sent_at"
      t.index ["email"], name: "index_users_on_email", unique: true

      t.timestamps
    end
  end
end
