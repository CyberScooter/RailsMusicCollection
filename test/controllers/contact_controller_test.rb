require 'test_helper'

class ContactControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contact_path
    assert_response :success
  end

end
