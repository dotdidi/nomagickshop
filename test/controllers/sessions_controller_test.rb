require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:user)
  end

  test "should get new" do
    get welcome_url
    assert_response :success
  end

  test "should be able to create new session" do
    log_in_as @user
    follow_redirect!
    assert_select 'div.alert', 'Welcome back, didi'
    assert_select 'h1', "Diota Tanara's Page"
    assert session[:user_id] == @user.id
  end

  test "should not be able to create new session without authentication" do
    post welcome_url, params: { session: {username: @user.username, password: 'pasword'}}
    assert_select 'div.alert', 'Invalid User name or password'
    assert_not session[:user_id] == @user.id
  end

  test "should be able to delete the session/log out" do
    log_in_as @user
    follow_redirect!
    assert session[:user_id] == @user.id
    delete bye_url
    follow_redirect!
    assert_not session[:user_id] == @user.id
    assert session[:user_id] == nil
  end

  test "cart should be connected to user when log in" do
    log_in_as @user
    follow_redirect!
    assert Cart.find(session[:cart_id]).user_id == @user.id
  end
end
