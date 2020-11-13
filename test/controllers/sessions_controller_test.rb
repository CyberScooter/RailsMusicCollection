require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login page" do
    get login_url
    assert_response :success
  end

  test "should login" do
    assert_difference('User.count') do
      post login_url, params: { login: {username: 'Test', password: 'Test123'}}
    end

    assert_equal "User has been successfully registered", flash[:notice]
    assert_redirected_to root_url
  end

  test "should try login invalid user" do

  end

end
