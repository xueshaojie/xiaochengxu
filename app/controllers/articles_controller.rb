class ArticlesController < ApplicationController

  before_action :authenticate_user! , only: [:new, :create, :show, :edit, :update, :destroy, :list]


  def index
    @articles = Article.publish.latest

    respond_to do |format|
      format.html
      format.json
    end
  end

  def list
    # @articles = Article.current_user.latest
    @articles = current_user.articles.latest

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = '保存成功'
      redirect_to list_articles_path
    else
      flash[:alert] = '保存失败'
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      flash[:notice] = '更新成功'
      redirect_to list_articles_path
    else
      flash[:alert] = '更新成功'
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end
  #
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


  # @ResponseBody
  #   @RequestMapping(value = "/decodeUserInfo", method = RequestMethod.POST)
  #   def decodeUserInfo(encryptedData, iv,code) {
  #
  #       if (code == null || code.length() == 0) {
  #           put("status", 0);
  #           put("msg", "code 不能为空");
  #           redirect_to :back;
  #       }
  #
  #       appid = 'wxf3c6f40bea069985';
  #       secret = '454126a4ac934e556c5565f840dff609';
  #       grant_type = 'authorization_code';
  #
  #
  #       # //////////////// 1、向微信服务器 使用登录凭证 code 获取 session_key 和 openid ////////////////
  #       # //请求参数
  #       params = "appid=" + wxspAppid + "&secret=" + wxspSecret + "&js_code=" + code + "&grant_type=" + grant_type;
  #       # //发送请求
  #       sr = HttpRequest.sendGet("https://api.weixin.qq.com/sns/jscode2session", params);
  #       # //解析相应内容（转换成json对象）
  #       json = JSONObject.fromObject(sr);
  #       # //获取会话密钥（session_key）
  #       session_key = json.get("session_key").to_s;
  #       # //用户的唯一标识（openid）
  #       openid = () json.get("openid");
  #
  #       # //////////////// 2、对encryptedData加密数据进行AES解密 ////////////////
  #       try {
  #            result = AesCbcUtil.decrypt(encryptedData, session_key, iv, "UTF-8");
  #           if (null != result && result.length() > 0) {
  #               map.put("status", 1);
  #               map.put("msg", "解密成功");
  #
  #               JSONObject userInfoJSON = JSONObject.fromObject(result);
  #               Map userInfo = new HashMap();
  #               userInfo.put("openId", userInfoJSON.get("openId"));
  #               userInfo.put("nickName", userInfoJSON.get("nickName"));
  #               userInfo.put("gender", userInfoJSON.get("gender"));
  #               userInfo.put("city", userInfoJSON.get("city"));
  #               userInfo.put("province", userInfoJSON.get("province"));
  #               userInfo.put("country", userInfoJSON.get("country"));
  #               userInfo.put("avatarUrl", userInfoJSON.get("avatarUrl"));
  #               userInfo.put("unionId", userInfoJSON.get("unionId"));
  #               map.put("userInfo", userInfo);
  #               return map;
  #           }
  #       } catch (Exception e) {
  #           e.printStackTrace();
  #       }
  #       map.put("status", 0);
  #       map.put("msg", "解密失败");
  #       return map;
  #   }
  # end

  private

  def article_params
    params.require(:article).permit!
  end


end
