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

    result = cipher.update(encrypted_data) + cipher.final
    decrypted = JSON.parse(result)
    raise('Invalid Buffer') if decrypted['watermark']['appid'] != @app_id

    decrypted
  end
end
