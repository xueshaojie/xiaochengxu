require 'openssl'
require 'base64'
require 'json'
# encoding: utf-8

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

    result = cipher.update(encrypted_data) + cipher.final
    decrypted = JSON.parse(result)
    raise('Invalid Buffer') if decrypted['watermark']['appid'] != @app_id

    decrypted
  end
end

# require 'openssl'
# require 'base64'
# require 'json'
#
# class AES128
#   class << self
#     def encrypt(data)
#       cipher = OpenSSL::Cipher::AES.new(128, :CBC)
#       cipher.encrypt
#       cipher.key = 'd6F3Efeqd6F3Efeqd6F3Efeqd6F3Efeq'
#       cipher.iv  = '1234567890123456'
#       cipher.update(data) << cipher.final
#     end
#
#     def decrypt(data)
#       cipher = OpenSSL::Cipher::AES.new(128, :CBC)
#       cipher.decrypt
#       cipher.key = 'd6F3Efeqd6F3Efeqd6F3Efeqd6F3Efeq'
#       cipher.iv  = '1234567890123456'
#       cipher.update(data) << cipher.final
#     end
#   end
# end
#
# p= AES128.encrypt('tumayun').unpack('H*').first
# p AES128.decrypt(['cc6238fca48f60c98e7cf09f8f681ccc'].pack('H*'))
#
# # app_id = 'wx87ec248ea93e7398'
# # iv = "Hm5ifm6zbVgZqOvJVL4i9A=="
# # session_key = 'ia0fXDBskItNKM1hy8+Emg=='
# # encrypted_data = "AfRKDHIbpaoWPBqq+GS6vIy3H2Ajpi4Xvx7jknWnA2z47h6WMRLRNoHecXIR6vxARvAOzPxkWwK49yfBCDfNV4/lyCcWJHNXQRo3EFO3DFkTaEe8OqA26cV8MYdJ/PVtPE868hUoDi38IAZF9eS+RzTflqNtJDXlmPHnln6VEILrAgglfrzBQlW84y4N7dKDVtbYfk+aLphe48HudOLT2WDolIno5rorEYQyaup1c5Z66N7ebrI1JMIdqk2eVqDgLdagCMp9c+llvVBX84VWJmhOXKGltTiHkAUvow0FNr4UzkggsQ5cTn7FcQ/83ifVZxn0VnRRy2mO3TN9fVIFo3/9/ABQIIKgKzKtNYl+uBtsjY5Uj53+wyNJdsJFOS/UNkutipEwKzw+Kz0iSguvRNz+gW8FfbUGJ8fXenLqBbIRRLP3XbeP8wSR3vYC1ZvSmZVQzLpogzY4AuN0q0+aPQ=="
#
# # app_id = 'wx4f4bc4dec97d474b'
# # iv = 'r7BXXKkLb8qrSNn05n0qiA=='
# # session_key = 'tiihtNczf5v6AKRyjwEUhQ=='
# # encrypted_data =
# # 'CiyLU1Aw2KjvrjMdj8YKliAjtP4gsMZMQmRzooG2xrDcvSnxIMXFufNstNGTyaGS9uT5geRa0W4oTOb1WT7fJlAC+oNPdbB+3hVbJSRgv+4lGOETKUQz6OYStslQ142dNCuabNPGBzlooOmB231qMM85d2/fV6ChevvXvQP8Hkue1poOFtnEtpyxVLW1zAo6/1Xx1COxFvrc2d7UL/lmHInNlxuacJXwu0fjpXfz/YqYzBIBzD6WUfTIF9GRHpOn/Hz7saL8xz+W//FRAUid1OksQaQx4CMs8LOddcQhULW4ucetDf96JcR3g0gfRK4PC7E/r7Z6xNrXd2UIeorGj5Ef7b1pJAYB6Y5anaHqZ9J6nKEBvB4DnNLIVWSgARns/8wR2SiRS7MNACwTyrGvt9ts8p12PKFdlqYTopNHR1Vf7XjfhQlVsAJdNiKdYmYVoKlaRv85IfVunYzO0IKXsyl7JCUjCpoG20f0a04COwfneQAGGwd5oa+T8yO5hzuyDb/XcxxmK01EpqOyuxINew=='
# #
# app_id = 'wxf3c6f40bea069985'
  # iv = 'uFdZtiIaxAftetHtjd7h/Q=='
# session_key = 'So2sNUTo0SYPX0tXOqoFbA=='
# encrypted_data = 'CCIkKX203R8pnlWaSGe5vNoYY4T/c6HpF8+OH0uagWWj6qVEhd+dLQlprDgUHJ/mHSl6IQBHHXAvNsPpddZ9pjK4vy8FKzTyZKuuU+s7082lOQsxojMpa8fPl7+lM37PAM+idLqJQoLwZDGgGy5SXAfjIeTUjxKUu2NBfJe/MBxqSrHqRHKkK6uq/MBuZ9OTarOr2vvq13KKzeUa0RkOBKadzkDBjZ8NR8PGftW/Y++P2e9t0xnBJ4YaU15qe6Qv0ugVubgKS70bQ+WWrU1CCLiyy7lyOYLwWe5/08/HDo5RfFfQ7x+5R9DU5xJNG41P8EUfcKIv9OKoJ9lp7/wgwYwz3Qhu4y8OmvdG0RBxPO37p7NDYpIt4N451eYVIoAjYE8CkBNjSd7bZsLcY2Q5YnXc7yqtx7L0l4XsqJzLzqK5VFRz+PVhLXmDXysTv4c+0hJFBGH0Vh53JJSe+9KnDGppuiBE71wMFnb6f/KCmcw='
#
#  p wx_middle = WxBizDataCrypt.new(app_id, session_key).decrypt(encrypted_data, iv)
