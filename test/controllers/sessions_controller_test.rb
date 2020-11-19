require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  #THE TESTS BELOW HANDLE LOGGING INTO AN ACCOUNT



  test "should get login page" do
    get login_url
    assert_response :success
  end

  test "should login" do
    #uses fixture users.yml details 
    assert_no_difference('User.count') do
      post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}
    end

    assert_equal "Successfully logged in", flash[:notice]
    assert_redirected_to root_url
  end

  #login to a user then logout
  test "should logout" do 
    #uses fixture users.yml details 
    assert_no_difference('User.count') do
      post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}
    end

    get logout_url

    assert_equal "Successfully logged out", flash[:notice]
    assert_redirected_to root_url
  end

  #login a user that is not in the database
  test "should try not login invalid user" do
    #uses fixture users.yml details 
    assert_no_difference('User.count') do
      post login_url, params: { session: {username: 'UserThatDoesNotExist', password: 'UserThatDoesNotExist123'}}
    end

    assert_equal "Invalid user", flash[:notice]
    assert_redirected_to login_url
  end

end
