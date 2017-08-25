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
    # @article.user_id = current_user.id
    # @article.user_id = params[:wx_user_id]

    if params[:wx_user_id]
      @wx_user = WxUser.find_by_id(params[:wx_user_id])
      current_user.id = @wx_user.user.id
      @article.user_id = current_user.id
    else
      @article.user_id = current_user.id
    end

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


  private

  def article_params
    params.require(:article).permit!
  end


end
