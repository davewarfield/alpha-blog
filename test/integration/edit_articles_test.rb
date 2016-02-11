require 'test_helper'

class EditArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
    @article = Article.create(title: "Hello, article", description: "Yada, yada", user_id: @user.id)
  end
  
  test "get edit article form and edit article" do
    sign_in_as(@user, "password")
    get edit_article_path(id: @article.id)
    assert_template 'articles/edit'
    assert_no_difference 'Article.count' do
      patch_via_redirect article_path(id: @article.id),
        article: {id: @article.id, title: "Goodbye", description: "Blah, blah", user_id: @user.id}
    end
    assert_template 'articles/edit'
    assert_no_match "Hello", response.body
    assert_no_match "Yada, yada", response.body
    assert_match "Goodbye", response.body
    assert_match "Blah, blah", response.body
  end
  
  test "invalid article edit results in failure" do
    sign_in_as(@user, "password")
    get edit_article_path(id: @article.id)
    assert_template 'articles/edit'
    assert_no_difference 'Article.count' do
      patch_via_redirect article_path(id: @article.id),
        article: {id: @article.id, title: "", description: "Blah, blah edit", user_id: @user.id}
    end
    assert_template 'articles/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
end