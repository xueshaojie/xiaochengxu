class Api::ArticlesController < Api::BaseController

  before_filter :cors_set_access_control_headers

  def index
    @articles = Article.all

    respond_to do |format|
      format.json
    end
  end

  def show
    @website_article = WebsiteArticle.find(params[:id])
    respond_to do |format|
      format.json
    end
  end


  private

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = '*'
      headers['Access-Control-Allow-Headers'] = '*'
    end

    def article_params
      params.require(:article).permit(:title, :text)
    end

end
