require 'test_helper'

class AuthorizationControllerTest < ActionDispatch::IntegrationTest
  test "should get callback" do
    get authorization_callback_url
    assert_response :success
  end

  test "should get create" do
    get authorization_create_url
    assert_response :success
  end

end
