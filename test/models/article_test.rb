require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  def setup
    @article = Article.new(title: "Hello, article", description: "Yada, yada", user_id: 1)  
  end
  
  test "article should be valid" do
    assert @article.valid?
  end
  
  test "title should be present" do
    @article.title = ""
    assert_not @article.valid?
  end
  
  test "title should not be too long" do
    @article.title = "a" * 51
    assert_not @article.valid?
  end
  
  test "title should not be too short" do
    @article.title = "aa"
    assert_not @article.valid?  
  end
  
  test "description should be present" do
    @article.description = ""
    assert_not @article.valid?
  end
  
  test "description should not be too long" do
    @article.description = "a" * 3001
    assert_not @article.valid?
  end
  
  test "description should not be too short" do
    @article.description = "a"
    assert_not @article.valid?  
  end
  
  test "user_id should be present" do
    @article.user_id = nil
    assert_not @article.valid?
  end
  
end