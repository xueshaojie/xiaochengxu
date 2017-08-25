class WxUser < ActiveRecord::Base

  has_one :user


   after_create do
     User.create(
       email:  "#{self.openid}@gmail.com",
       password:  "123123123",
       password_confirmation: "123123123",
       wx_user_id: "#{self.id}"
     )


     if session.openid == self.openid
       return current_user
     else
       print "返回错误"
     end
   end



end
