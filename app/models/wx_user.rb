class WxUser < ActiveRecord::Base

  has_one :user


  after_create do
    self.user.create(
      email:  "xueshaojie12321@gmail.com",
      password:  "123123123",
      encrypted_password: "wetewsdfjiewwewerwsdfgwes",
      sign_in_count: "10"
    )
  end


end
