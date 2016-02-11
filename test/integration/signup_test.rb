class SignupTest < ActionDispatch::IntegrationTest
  
  test "sign up new user" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "John", email: "John@example.com", password: "password"}
    end
    @user = User.last
    assert_template 'users/show'
    assert_match @user.username, "John"
    assert_match @user.email, "john@example.com" 
    assert_match "Welcome to " + @user.username + "\'s page", response.body
  end

end