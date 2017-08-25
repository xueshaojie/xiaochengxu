class ArticlesController < ApplicationController

  #before_action :authenticate_user! , only: [:new, :create, :show, :edit, :update, :destroy, :list]


  def index
    @articles = Article.publish.latest

    respond_to do |format|
      format.html
      format.json
    end
  end

  def list
    # @articles = Article.current_user.latest
    if current_user
      @articles = current_user.articles.latest
    else
      @wx_user = WxUser.find_by_id(params[:wx_user_id])
      @user = @wx_user.user
      @articles = @user.articles.latest
    end

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

    if params[:wx_user_id]
      @wx_user = WxUser.find_by_id(params[:wx_user_id])
      @user = @wx_user.user
      @article.user_id = @user.id
      if @article.save
        flash[:notice] = '保存成功'
        redirect_to articles_path 
      else
        flash[:alert] = '保存失败'
        render 'new'
      end
    else
      @article.user_id = current_user.id
      if @article.save
        flash[:notice] = '保存成功'
        redirect_to list_articles_path
      else
        flash[:alert] = '保存失败'
        render 'new'
      end
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


  private

  def article_params
    params.require(:article).permit!
  end


end
