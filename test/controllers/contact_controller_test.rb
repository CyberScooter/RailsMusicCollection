require 'test_helper'

class ContactControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contact_path
    assert_response :success
  end

  test "should send contact message" do
    post contact_url, params: { contact: {name: 'John', email: 'test@test.com', message: 'Test message'}}

    assert_equal "Message successfully sent", flash[:notice]
    assert_redirected_to contact_path
  end

end
