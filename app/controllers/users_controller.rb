class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :currect_user,   only: [:edit, :update]

  def index
    @users = User.where(activated: true) . paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = '保存成功'
      session[:user_id] = @user.id
      log_in @user
      redirect_to @user
    else
      flash[:alert] = '保存失败'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "更新成功"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def currect_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end
