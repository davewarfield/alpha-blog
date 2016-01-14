class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    #render plain: params[:article].inspect
    #
    @article = Article.new(article_params)

    # Next lines done first, but no validation
    #@article.save
    # bad - wrong pathredirect_to articles_show(@article)
    #redirect_to article_path(@article)


    # Next lines add validation
    if (@article.save)
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end