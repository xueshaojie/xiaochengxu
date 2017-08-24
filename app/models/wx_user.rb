class WxUser < ActiveRecord::Base

  has_one :user


  after_create do
    self.user.create(
      email:  "xueshaojie12321@gmail.com",
      password:  "123123123",
      password_confirmation: "123123123"
    )
  end


end
