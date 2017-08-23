class WxUser < ApplicationRecord

  belongs_to :user


  # def weixinlogin(user_id=null)
  #   global App_Error_Conf,Gift_Ids,Server_Http_Path,Is_Local,Test_User,Good_Vcode,WeiXin_Xd_Conf;
  #   validator_result = input_validator(array('code','iv','encryptedData'));
  #   return response(validator_result) unless validator_result.empty?
  #
  #   js_code = params[:code];
  #   encryptedData = params[:encryptedData];
  #   iv = params[:iv];
  #   appid = 'wxf3c6f40bea069985';
  #   secret = '454126a4ac934e556c5565f840dff609';
  #   grant_type = 'authorization_code';
  #   # 从微信获取session_key
  #   user_info_url = WeiXin_Xd_Conf['code2session_url'];
  #   user_info_url = ("%s?appid=%s&secret=%s&js_code=%s&grant_type=%",user_info_url,appid,secret,js_code,grant_type).to_s;
  #   weixin_user_data = json_decode(get_url(user_info_url));
  #   # session_key = weixin_user_data->session_key;
  #   session_key = json.get("session_key").to_s;
  #   # 解密数据
  #   data = '';
  #   wxBizDataCrypt = WXBizDataCrypt.new(appid, session_key);
  #   errCode=wxBizDataCrypt>decryptData(appid,session_key,encryptedData, iv, data );
  # end
  #
  #   def weixinlogin
  #
  #     js_code = params[:code];
  #     encryptedData = params[:encryptedData];
  #     iv = params[:iv];
  #     appid = 'wxf3c6f40bea069985';
  #     secret = '454126a4ac934e556c5565f840dff609';
  #
  #     # if WxUser.find_by_openid(openid)?
  #       if params[:code].present?
  #         url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{appid}&secret=#{secret}&js_code=#{params[:code]}&grant_type=authorization_code"
  #         # https://api.weixin.qq.com/sns/jscode2session?appid=wxf3c6f40bea069985&secret=454126a4ac934e556c5565f840dff609&js_code=003vijro14ApGo0c5Fto1cuero1vijr5&grant_type=authorization_code
  #         result = RestClient.get(url)
  #         logger.info "*******************authorize result:#{result}"
  #
  #         weixin_user_data = JSON(result)
  #
  #         session_key, openid = weixin_user_data.values_at('session_key', 'openid')
  #
  #         third_session = [*'a'..'z',*'0'..'9',*'A'..'Z'].sample(16).join
  #         session[:third_session] = {}
  #         session[:third_session][:openid] = openid
  #         session[:third_session][:session_key] = session_key
  #
  #         unless WxUser.find_by_openid(openid)?
  #           WxUser.create (openid: openid)
  #         end
  #
  #
  #         signature = params[:signature]
  #         rawdata = params[:rawdata]
  #         signature2 = sha1(rawdata.session_key);
  #         arr = ["signature"=>signature, "signature2"=>signature2];
  #         arr_json = json_encode(arr);
  #         # //发送给小程序，在wx.request()的sucess方法接收
  #         arr_json;
  #
  #
  #
  #         session[:user_id] = @wx_user.user_id
  #         session[:openid] = @wx_user.openid
  #         @user = @wx_user.user
  #
  #         return redirect_to auth_back
  #       end
  #
  #       oauth_url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{app_id}&redirect_uri=#{Rack::Utils.escape(request.url)}&response_type=code&scope=snsapi_userinfo&state=#{STATE}#wechat_redirect"
  #       redirect_to oauth_url
  #     end
  #   rescue => e
  #     SiteLog::Base.logger('weixin_oauth', "weixin_oauth with user info  error: #{e.message} > #{e.backtrace}")
  #     require_wx_user
  #   end
  #
  # end


end
