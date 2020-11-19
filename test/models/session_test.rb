require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  #MODEL USED FOR LOG IN PURPOSES
  #rest is taken care in controller

  test "should proceed to login authentication" do
    session = Session.new
    session.username = "Test"
    session.password = "Test123456"

    assert session.valid?
  end
  

  test "should check if empty" do
    session = Session.new
    session.username = ""
    session.password = ""

    assert_not session.valid?
  end

end
