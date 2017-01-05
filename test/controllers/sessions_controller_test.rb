require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:didi)
    @cart = carts(:one)
  end

  test "should get new" do
    get welcome_url
    assert_response :success
  end

  test "should be able to create new session" do
    post welcome_url, params: { session: {username: @user.username, password: 'password'}}
    follow_redirect!
    assert_select 'h1', "Diota Tanara's Page"
  end

end
