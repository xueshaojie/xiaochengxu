class WxUser < ActiveRecord::Base

  has_one :user


   after_create do
     User.create(
       email:  "xueshaojie12321@gmail.com",
       password:  "123123123",
       password_confirmation: "123123123",
       wx_user_id: "#{self.id}"
     )
   end



end
