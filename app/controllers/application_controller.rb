class ApplicationController < ActionController::Base
  #skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  #protect_from_forgery with: :exception


  #protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "请登录，在执行操作。"
      redirect_to login_url
    end
  end
end
