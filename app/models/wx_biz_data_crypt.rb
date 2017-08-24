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
# iv = 'EXVXlbGGYKBGE1AHrTSHTA=='
# session_key = 'So2sNUTo0SYPX0tXOqoFbA=='
# encrypted_data = 'l4GpjKb4%2BD4E2Ia0p2q3Yf13jxA%2BCKv0i3hZbTQTKPXiF7%2B5gB%2FlrY%2Bt5SY%2Fc%2Favm3iR69Wkq7LWdu9NPH0E7uC2HJYr5l3xk1HlMpVwgsrw1yH4wNc8sezkS7zdmo%2BqxXe8pbSd2drpbVLDVEFUNpldndDRmcbkKgyCNjOH6te9ujJNjXyJX1E0ptDpM5TVYu4Mj9byKSfv8UL5vmCPOC5oXrYyRPrLiTVbHc3Cy4t3iEo5AQlWa7AUyWRUcJ%2F7DD9hoJgXm97K8dafX64mIkCSS0apC%2Fg5dLcdlHoI6PZCBRonTTXYeKSgphutpeStGwb%2BbqGjQPC%2FZ9ErNS4A8%2BR3ijplgXJg6Fz8MtI%2BibukPjZpuB0kHkFchKJG1skweaCRFRMTBL6YyX2k1dw2EEdYLYqo2i%2Bht3ckqlBulZZVBq9GSzEPrxHobTZ4HzPilUipqdQAfMhPwRNx0%2F6%2BuXWsbiC7XtiotEEdy3BdvV4%3D'
#
#  p wx_middle = WxBizDataCrypt.new(app_id, session_key).decrypt(encrypted_data, iv)
