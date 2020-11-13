require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase


  test "should return contact email" do
    mail = ContactMailer.contact_email("matthew@me.com","Matthew Casey",  @message = "Hello")
    assert_equal ['info@musiccollection.com'], mail.to
    assert_equal ['info@musiccollection.com'], mail.from
  end
end
