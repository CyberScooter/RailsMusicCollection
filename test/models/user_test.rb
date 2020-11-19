require 'test_helper'

class UserTest < ActiveSupport::TestCase
  #MODEL USED FOR SIGNING UP/REGISTER PURPOSES
  #rest is taken care in controller

  test "should register" do
    user = User.new

    user.username = "Test"
    user.password = "Test12345"
    user.password_confirmation = "Test12345"

    assert user.valid?

  end

  test "should not register for null values" do
    user = User.new

    user.username = ""
    user.password = ""
    user.password_confirmation = ""

    assert_not user.valid?

  end

  test "should not register if password length short" do
    user = User.new

    user.username = "Test"
    user.password = "Test123"
    user.password_confirmation = "Test123"

    assert_not user.valid?

  end



end
