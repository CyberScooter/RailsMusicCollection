require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  #THE TESTS BELOW HANDLE REGISTERING AN ACCOUNT


  test "should get register page" do
    get register_url
    assert_response :success
  end

  #user is registered a new account, this creates a session and user no longer needs to login after registration
  test "should register" do 
    assert_difference('User.count') do
      post register_url, params: { user: { username: 'Test', password: 'Test12345', password_confirmation: 'Test12345' } }
    end

    assert_equal "User has been successfully registered", flash[:notice]
    assert_redirected_to root_url
  end

  #trying to register a user that already exists, session is NOT created and user is redirected to register url
  test "should not register" do
    assert_no_difference('User.count') do
      post register_url, params: { user: { username: 'AnExistingUser', password: 'AnExistingUser123', password_confirmation: 'AnExistingUser123' } }
    end

    assert_equal "Username already exists", flash[:notice]
    assert_redirected_to register_url
  end

  #if user tries to access "/logout" while not being logged in, redirects to login page and tells user to login
  test "should not logout" do 
    get logout_url

    assert_equal "Please login", flash[:notice]
    assert_redirected_to login_url
  end

end
