class WxUsersController < ApplicationController

  def wei_xin_login

    js_code = params[:code];
    encrypted_data = params[:encryptedData];
    iv = params[:iv];
    appid = 'wxf3c6f40bea069985';
    secret = '454126a4ac934e556c5565f840dff609';

    if params[:code].present?
      url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{appid}&secret=#{secret}&js_code=#{params[:code]}&grant_type=authorization_code"
      result = RestClient.get(url)
      logger.info "*******************authorize result:#{result}"

      weixin_user_data = JSON(result)

      session_key, openid = weixin_user_data.values_at('session_key', 'openid')

      third_session = [*'a'..'z',*'0'..'9',*'A'..'Z'].sample(16).join
      session[:third_session] = {}
      session[:third_session][:openid] = openid
      session[:third_session][:session_key] = session_key
      WxUser.create(openid: openid) unless WxUser.find_by_openid(openid)?

      #wx_middle = WxBizDataCrypt.new(app_id, session_key).decrypt(encrypted_data, iv)
    end
  end

end
