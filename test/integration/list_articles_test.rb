require 'test_helper'

class ListArticlessTest < ActionDispatch::IntegrationTest
  
  def setup
    @article1 = Article.create(title: "Hello", description: "Yada, yada", user_id: 1)
    @article2 = Article.create(title: "Goodbye", description: "Blah, blah", user_id: 2)
  end
  
  test "should show articles listing" do
    get articles_path
    assert_template 'articles/index'
    assert_select "a[href=?]", article_path(@article1), text: @article1.title
    assert_select "a[href=?]", article_path(@article2), text: @article2.title
  end
  
end