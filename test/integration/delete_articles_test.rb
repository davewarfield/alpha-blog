require 'test_helper'

class DeleteArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
    @article = Article.create(title: "Hello, article", description: "Yada, yada", user_id: @user.id)
  end
  
  test "get article page and delete article" do
    sign_in_as(@user, "password")
    get article_path(id: @article.id)
    assert_template 'articles/show'
    assert_difference 'Article.count', -1 do
      delete_via_redirect article_path(id: @article.id), article: {title: "Hello", description: "Yada, yada", user_id: @user.id}
    end
    assert_template 'articles/index'
  end
  
end