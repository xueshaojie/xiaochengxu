class WxUsersController < BaseController

  def wx_login
    js_code = params[:code]
    encrypted_data = params[:encryptedData]
    iv = params[:iv]
    app_id = 'wxf3c6f40bea069985'
    secret = '454126a4ac934e556c5565f840dff609'

    if params[:code].present?
      url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{app_id}&secret=#{secret}&js_code=#{params[:code]}&grant_type=authorization_code"
      result = RestClient.get(url)
      logger.info "*******************authorize result:#{result}"

      weixin_user_data = JSON(result)

      session_key = weixin_user_data.values_at('session_key').first
      openid = weixin_user_data.values_at('openid').first

      # session_key, openid = weixin_user_data.values_at('session_key', 'openid')

      third_session = [*'a'..'z',*'0'..'9',*'A'..'Z'].sample(16).join
      session[:third_session] = {}
      session[:third_session][:openid] = openid
      session[:third_session][:session_key] = session_key
      WxUser.create(openid: openid) unless WxUser.find_by_openid(openid)

      session[:openid] = openid


      wx_middle = WxBizDataCrypt.new(app_id, session_key).decrypt(encrypted_data, iv)

      nickName = wx_middle.values_at('nickName').first
      openId = wx_middle.values_at('openId').first
      gender = wx_middle.values_at('gender').first
      city = wx_middle.values_at('city').first
      province = wx_middle.values_at('province').first
      country = wx_middle.values_at('country').first
      avatarUrl = wx_middle.values_at('avatarUrl').first
      unionid = wx_middle.values_at('unionId').first


      if openId == openid
        WxUser.find_by_openid(openid).update(
          nickName: nickName,
          gender: gender,
          city: city,
          province: province,
          country: country,
          avatarUrl: avatarUrl,
          unionid: unionid
        )
      end


      @wx_user = WxUser.find_by_openid(openid) rescue nil

      if @wx_user
        @wx_user.update(
        nickName: nickName,
        gender: gender,
        city: city,
        province: province,
        country: country,
        avatarUrl: avatarUrl
      )
        return render json: {wx_user: @wx_user}
      end

    end
  end

end
