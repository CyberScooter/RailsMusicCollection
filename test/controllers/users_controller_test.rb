require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get register page" do
    get register_url
    assert_response :success
  end

  #user is registered a new account
  test "should register" do 
    assert_difference('User.count') do
      post register_url, params: { user: { username: 'Test', password: 'Test123', password_confirmation: 'Test123' } }
    end

    assert_equal "User has been successfully registered", flash[:notice]
    assert_redirected_to root_url
  end

  #user should be able to logout because they're logged in automatically after successful registration above
  test "should logout" do 
    get logout_url

    assert_equal "Please login", flash[:notice]
    assert_redirected_to login_url
  end

end
