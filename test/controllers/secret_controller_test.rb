require 'test_helper'

class SecretControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get secret_new_url
    assert_response :success
  end

end
