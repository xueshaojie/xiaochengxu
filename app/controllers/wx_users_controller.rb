class WxUsersController < ApplicationController

  def wei_xin_login

    js_code = params[:code];
    encrypted_data = params[:encryptedData];
    iv = params[:iv];
    appid = 'wxf3c6f40bea069985';
    secret = '454126a4ac934e556c5565f840dff609';

    # if WxUser.find_by_openid(openid)?
    if params[:code].present?
      url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{appid}&secret=#{secret}&js_code=#{params[:code]}&grant_type=authorization_code"
      # https://api.weixin.qq.com/sns/jscode2session?appid=wxf3c6f40bea069985&secret=454126a4ac934e556c5565f840dff609&js_code=013uOIU52aQSUN09oxU52leEU52uOIUW&grant_type=authorization_code
      result = RestClient.get(url)
      logger.info "*******************authorize result:#{result}"

      weixin_user_data = JSON(result)

      session_key, openid = weixin_user_data.values_at('session_key', 'openid')

      third_session = [*'a'..'z',*'0'..'9',*'A'..'Z'].sample(16).join
      session[:third_session] = {}
      session[:third_session][:openid] = openid
      session[:third_session][:session_key] = session_key

      WxUser.create(openid: openid) unless WxUser.find_by_openid(openid)?

      #fruit = AesCbcUtil.decrypt(encryptedData, session_key, iv, "UTF-8");
      pc = WXBizDataCrypt.new(app_id, session_key)
      fruit = pc.decrypt(encrypted_data, iv)
      if (null != fruit && fruit.length() > 0)
        print "msg:解密成功"
        openId, nickName, gender, city, province, country, avatarUrl, unionId = fruit.values_at('openId', 'nickName', 'gender', 'city', 'province', 'country', 'avatarUrl', 'unionId')

      else
        print "msg:解密失败"
      end

      if openId == openid
        WxUser.find_by_openid(openid).update(
          nickName: nickName,
          gender: gender,
          city: city,
          province: province,
          country: country,
          avatarUrl: avatarUrl,
          unionId: unionId
        )
      end
    end
  end

end
      #   signature = params[:signature]
      #   rawdata = params[:rawdata]
      #   signature2 = sha1(rawdata.session_key);
      #   arr = ["signature"=>signature, "signature2"=>signature2];
      #   arr_json = json_encode(arr);
      #   # //发送给小程序，在wx.request()的sucess方法接收
      #   arr_json;
      #
      #
      #
      #   return redirect_to auth_back
      # end


  # end
