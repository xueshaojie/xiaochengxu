# encoding: UTF-8

# class WxBizDataCrypt
#   def initialize(app_id, session_key)
#     @app_id = app_id
#     @session_key = Base64.decode64(session_key)
#   end
#
#   def decrypt(encrypted_data, iv)
#     encrypted_data = Base64.decode64(encrypted_data)
#     iv = Base64.decode64(iv)
#
#     cipher = OpenSSL::Cipher::AES.new(128, :CBC)
#     cipher.decrypt
#     # cipher.padding = 0
#     cipher.key = @session_key
#     cipher.iv  = iv
#     data = cipher.update(encrypted_data) << cipher.final
#     result = JSON.parse(data[0...-data.last.ord])
#
#     raise '解密错误' if result['watermark']['appid'] != @app_id
#     result
#   end
# end

require 'openssl'
require 'base64'
require 'json'

class WxBizDataCrypt
  attr_accessor :app_id, :session_key

  def initialize(app_id, session_key)
    @app_id = app_id
    @session_key = session_key
  end

  def decrypt(encrypted_data, iv)
    session_key = Base64.decode64(@session_key)
    encrypted_data= Base64.decode64(encrypted_data)
    iv = Base64.decode64(iv)

    cipher = OpenSSL::Cipher::AES128.new(:CBC)
    cipher.decrypt
    cipher.key = session_key
    cipher.iv = iv

    decrypted = JSON.parse(cipher.update(encrypted_data) + cipher.final)
    raise('Invalid Buffer') if decrypted['watermark']['appid'] != @app_id

    decrypted
  end
end

# app_id = 'wx4f4bc4dec97d474b'
# iv = 'r7BXXKkLb8qrSNn05n0qiA=='
# session_key = 'tiihtNczf5v6AKRyjwEUhQ=='
# encrypted_data =
# 'CiyLU1Aw2KjvrjMdj8YKliAjtP4gsMZMQmRzooG2xrDcvSnxIMXFufNstNGTyaGS9uT5geRa0W4oTOb1WT7fJlAC+oNPdbB+3hVbJSRgv+4lGOETKUQz6OYStslQ142dNCuabNPGBzlooOmB231qMM85d2/fV6ChevvXvQP8Hkue1poOFtnEtpyxVLW1zAo6/1Xx1COxFvrc2d7UL/lmHInNlxuacJXwu0fjpXfz/YqYzBIBzD6WUfTIF9GRHpOn/Hz7saL8xz+W//FRAUid1OksQaQx4CMs8LOddcQhULW4ucetDf96JcR3g0gfRK4PC7E/r7Z6xNrXd2UIeorGj5Ef7b1pJAYB6Y5anaHqZ9J6nKEBvB4DnNLIVWSgARns/8wR2SiRS7MNACwTyrGvt9ts8p12PKFdlqYTopNHR1Vf7XjfhQlVsAJdNiKdYmYVoKlaRv85IfVunYzO0IKXsyl7JCUjCpoG20f0a04COwfneQAGGwd5oa+T8yO5hzuyDb/XcxxmK01EpqOyuxINew=='


# app_id = 'wxf3c6f40bea069985'
# iv = '+6RHSf/Dddx15m2+5Yg8cg=='
# session_key = 'u5F/9T+l7akd/E7iGCfjoA=='
# encrypted_data = 'ZFSE03m1O6K6bQDOwhE4O9wB%2BdvgfBZ1YtuB7RXxLWnzSbSkeORgJrhKRTgEn1ffOk1%2BWfQsDGzaUl%2BB8LHjF13a3H16KsdOyzllcMyZnYoh2jHXr0yT9Du83VZ6%2FNMSZRJ1IdoCwxSnjKq4ARO9GX90LzoYIMxP1YrX2gifhS7e5W6saarODzcD000hzFednhjBVjrSC%2FLQ3mdq8xilPPKVe8fC7VVv79olAwC3e1NrzUi8glruAnCT4%2FH2w5fpt35v%2FVZQSr4O87xYHfp3nS3tZTVua28AvT4drvBbC6YMRqdoBUOKxYMnap6NsfH%2B3Ia%2FjhI2kpVIaLR6GD23EpCb53Pw000xniUuhHOLq5HLG3MytiF%2BQ%2FJQ3Omol6GMg%2F8W8aqJiKNSSd%2FahH4n5VrWHziw%2BzmROp8R4n6xrnBmo4%2B6cK%2Fi3O2oks8JdkPlPWcabJgXRtuYZSzmzTJH5G338Va1JTymTtazIqt93rg%3D'

# wx_middle = WxBizDataCrypt.new(app_id, session_key).decrypt(encrypted_data, iv)
# # puts  "*********"
#
# p  wx_middle.values_at('nickName').first
# p  wx_middle.values_at('gender')
# p openId = wx_middle.values_at('openId')
# p gender = wx_middle.values_at('gender')
# p city = wx_middle.values_at('city')
# p province = wx_middle.values_at('province')
# p country = wx_middle.values_at('country')
# p avatarUrl = wx_middle.values_at('avatarUrl')
# p unionid = wx_middle.values_at('unionId')
#
# p gender.first



# puts a.to_a
# p a.to_a.first[1]
