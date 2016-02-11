require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  def setup
    @user1 = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
    @user2 = User.create(username: "sally", email: "sally@example.com", password: "password", admin: false)
    @article = Article.create(title: "Hello, article", description: "Yada, yada", user_id: @user1.id)
  end
  
  test "should get articles index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    session[:user_id] = @user1.id
    get :new
    assert_response :success  
  end
  
  test "should get show" do
    get(:show, { 'id' => @article.id })
    assert_response :success  
  end
  
  test "should get edit" do
    session[:user_id] = @user1.id
    get(:edit, { 'id' => @article.id })
    assert_response :success  
  end
  
  test "should get destroy" do
    session[:user_id] = @user1.id
    get(:destroy, { 'id' => @article.id })
    assert_redirected_to articles_path
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Article.count' do
      post :create, article: { title: "Hello, new article", description: "Yada, yada" }
    end
    assert_redirected_to root_path
  end
  
  test "should redirect edit when logged in but not creator" do
    session[:user_id] = @user2.id
    get(:edit, { 'id' => @article.id })
    assert_redirected_to root_path
  end
  
end