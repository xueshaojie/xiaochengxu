class WxUser < ActiveRecord::Base

  has_one :user


  after_create do
    self.user.create (
      email:  "xueshao@gmail.com",
      password:  "123123"
    )
  end


end
