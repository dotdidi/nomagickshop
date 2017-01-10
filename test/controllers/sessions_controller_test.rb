require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:didi)
    @cart = carts(:cart1)
  end

  test "should get new" do
    get welcome_url
    assert_response :success
  end

  test "should be able to create new session" do
    log_in_as @user
    follow_redirect!
    assert_select 'h1', "Diota Tanara's Page"
    assert session[:user_id] == @user.id
  end

  test "should not be able to create new session without authentication" do
    post welcome_url, params: { session: {username: @user.username, password: 'pasword'}}
    assert_select 'div.alert', 'Invalid User name or password'
    assert_not session[:user_id] == @user.id
  end
end
