require 'openssl'
require 'base64'
require 'json'
require 'socket'
require 'thread'
require 'digest/sha1'

class WxBizDataCrypt
  def initialize(app_id, session_key)
    @app_id = app_id
    @session_key = Base64.decode64(session_key)
  end

  def self.decrypt(encrypted_data, iv)
    encrypted_data = Base64.decode64(encrypted_data)
    iv = Base64.decode64(iv)

    cipher = OpenSSL::Cipher::AES.new(128, ':CBC')
    cipher.decrypt
    # cipher.padding = 0
    cipher.key = @session_key
    cipher.iv  = iv
    #data = cipher.update(encrypted_data) + cipher.final
    #result = JSON.parse(data[0...-data.last.ord])
    result = JSON.parse(cipher.update(encrypted_data) + cipher.final)

    raise '解密错误' if result['watermark']['appid'] != @app_id
    result
  end
end

# class WXBizDataCrypt
#   attr_accessor :app_id, :session_key
#
#   def initialize(app_id, session_key)
#     @app_id = app_id
#     @session_key = session_key
#   end
#
#   def decrypt(encrypted_data, iv)
#     session_key = Base64.decode64(@session_key)
#     encrypted_data= Base64.decode64(encrypted_data)
#     iv = Base64.decode64(iv)
#
#     cipher = OpenSSL::Cipher::AES128.new(:CBC)
#     cipher.decrypt
#     cipher.key = session_key
#     cipher.iv = iv
#
#     decrypted = JSON.parse(cipher.update(encrypted_data) + cipher.final)
#     raise('Invalid Buffer') if decrypted['watermark']['appid'] != @app_id
#
#     decrypted
#   end
# end

# app_id = 'wxf3c6f40bea069985'
# iv = 'BK54qx9bQJuyIIHFpXSeQg=='
# session_key = 'pXZ5FQbcbYJFN1EojDBDEg=='
# encrypted_data = 'rG20eSAOKIjMJpv3j31WbCS7RDTrDUYJECqt0lS9jkEk3rEybF5tV5WPbGAzoujPgsrADQDAkm4RkMX4ZUDYYn56HD3vKDnSaPMPFfPCIyiFMdHqFqLo%2BzeQ9C3AyXX8puCOsloDz%2BE8q8%2Fdd7I7RG7iNfyUU8K2LzmyPezwZq4zakt5Z5bkcIKHScIdUYSI67mXS6%2FpGEbgC5CxzCvDHGWBDFd%2F6lcMWvUV3wnXFzjT5mGfj6S%2BMVSDNWLVynFpFSlCUQcC7HV94iTQKCRd6ymHfGR378pTZCZIahXFWl%2BiJdBHwkweqr6JKhYM05%2BRh51On%2FaYjNlIGLOZjPoIMQYPod5ulrtxU2sCAGlrZZbVKpl7Se06xqUBJtBRpWXGsRZnj%2BFOaqLfwPEJxXqmbGSWIJK02psD0FKZaUcXM9DkDzQl7wpjcg%2FdKc9DMZwUJPv9PRGqwHwtIY4FGjLTr6kK4DlqMqXUIitLDzlqmSs%3D'
#
# # app_id = 'wx4f4bc4dec97d474b'
# # iv = 'r7BXXKkLb8qrSNn05n0qiA=='
# # session_key = 'tiihtNczf5v6AKRyjwEUhQ=='
# # encrypted_data =
# # 'CiyLU1Aw2KjvrjMdj8YKliAjtP4gsMZMQmRzooG2xrDcvSnxIMXFufNstNGTyaGS9uT5geRa0W4oTOb1WT7fJlAC+oNPdbB+3hVbJSRgv+4lGOETKUQz6OYStslQ142dNCuabNPGBzlooOmB231qMM85d2/fV6ChevvXvQP8Hkue1poOFtnEtpyxVLW1zAo6/1Xx1COxFvrc2d7UL/lmHInNlxuacJXwu0fjpXfz/YqYzBIBzD6WUfTIF9GRHpOn/Hz7saL8xz+W//FRAUid1OksQaQx4CMs8LOddcQhULW4ucetDf96JcR3g0gfRK4PC7E/r7Z6xNrXd2UIeorGj5Ef7b1pJAYB6Y5anaHqZ9J6nKEBvB4DnNLIVWSgARns/8wR2SiRS7MNACwTyrGvt9ts8p12PKFdlqYTopNHR1Vf7XjfhQlVsAJdNiKdYmYVoKlaRv85IfVunYzO0IKXsyl7JCUjCpoG20f0a04COwfneQAGGwd5oa+T8yO5hzuyDb/XcxxmK01EpqOyuxINew=='
#
# pc = WXBizDataCrypt.new(app_id, session_key)
# puts pc.decrypt(encrypted_data, iv)
