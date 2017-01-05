require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:didi)
    @other = users(:jasper)
  end

  test "should log in before access index" do
    get users_url
    assert_response :redirect , "Users index can be access without log in"

    get welcome_url
    post welcome_url, params: { session: {username: @user.username, password: 'password'}}
    get users_url
    assert_response :success, "Users index cannot be access after log in"
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should log in before access edit user" do

    get edit_user_url(@user)
    assert_response :redirect, "Users can be edit without log in"
  end

  test "Log in successful" do

    get welcome_url
    post welcome_url, params: { session: {username: @user.username, password: 'password'}}
    assert is_logged_in?, "Log in is not succesful"
    assert_redirected_to @user, "Log in is not redirect back to profile"

    follow_redirect!
    assert_not flash.empty?, "There's no message when log in succesfully"
    delete bye_url
  end


  test "should not edit other user's prof" do

    get welcome_url
    post welcome_url, params: { session: {username: @user.username, password: 'password'}}
    get edit_user_url(@other)
    assert_response :redirect, "Users can be edit by other users "
    delete bye_url

  end

  test "able to edit self profile" do
    get welcome_url
    post welcome_url, params: { session: {username: @user.username, password: 'password'}}
    get edit_user_url(@user)
    assert_response :success
    delete bye_url
  end

  test "the show display either real name or user name" do
    log_in_as @user
    follow_redirect!
    assert_select 'h1', "Diota Tanara's Page"
    patch user_path(@user), params: { user: {username: @user.username, email: @user.email, password: 'password', password_confirmation: 'password', realname: ' '}}
    follow_redirect!
    assert_select 'h1', "didi's Page"
  end

end
