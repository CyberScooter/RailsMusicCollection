require 'test_helper'

class ContactTest < ActiveSupport::TestCase


  test "should send message" do
    contact = Contact.new

    contact.name = "John"
    contact.email = "john@example.com"
    contact.message = "Test message"

    #this is the first if statement in the controller to determine if message can be sent
    #checks if contact being sent is valid
    assert contact.valid?
  end

  test "should not send message with wrong email format" do
    contact = Contact.new

    contact.name = "John"
    contact.email = "john"
    contact.message = "Test message"

    #this is the first if statement in the controller to determine if message can be sent
    #checks if contact being sent is NOT valid
    assert_not contact.valid?
  end

  test "should not send message with null values" do
    contact = Contact.new

    contact.name = ""
    contact.email = ""
    contact.message = ""

    #this is the first if statement in the controller to determine if message can be sent
    #checks if contact being sent is NOT valid
    assert_not contact.valid?
  end

  test "should not send message with null value" do
    contact = Contact.new

    contact.name = ""
    contact.email = "test@example.com"
    contact.message = ""

    #this is the first if statement in the controller to determine if message can be sent
    #checks if contact being sent is NOT valid
    assert_not contact.valid?
  end
end
