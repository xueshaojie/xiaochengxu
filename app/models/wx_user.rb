class WxUser < ActiveRecord::Base

  has_one :user


   after_create do
     User.create(
       name: "#{self.nickName}",
       email: "#{self.openid}@gmail.com",
       password: "123123123",
       password_confirmation: "123123123",
       wx_user_id: "#{self.id}"
     )

   end

end
