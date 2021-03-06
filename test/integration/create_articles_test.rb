require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
  end
  
  test "get new article form and create article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "Hello", description: "Yada, yada", user_id: @user.id}
    end
    assert_template 'articles/show'
    assert_match "Hello", response.body
    assert_match "Yada, yada", response.body
  end
  
  test "invalid article submission results in failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    
    assert_no_difference 'Article.count' do
      post articles_path, article: {title: "", description: "Yada, yada edit", user_id: @user.id}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    
    assert_no_difference 'Article.count' do
      post articles_path, article: {title: "Hello edit", description: "", user_id: @user.id}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
end