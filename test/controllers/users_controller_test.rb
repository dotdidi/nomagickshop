require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:user, admin: true)
    @other = create(:user, username: 'jasper', realname: 'Jason Percy' )
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

  test "should Log in successful" do

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

  test "should able to access edit self profile" do
    get welcome_url
    post welcome_url, params: { session: {username: @user.username, password: 'password'}}
    get edit_user_url(@user)
    assert_response :success
    delete bye_url
  end

  test "should not be able to edit profile with blank username/email/password" do
    log_in_as @user
    patch user_path(@user), params: { user: {username: '   ', email: @user.email, password: 'password', password_confirmation: 'password'}}
    assert_select 'div.alert', 'Profile can not be updated for the moment.'
    
    patch user_path(@user), params: { user: {username: @user.username, email: '   ', password: 'password', password_confirmation: 'password'}}
    assert_select 'div.alert', 'Profile can not be updated for the moment.'

    patch user_path(@user), params: { user: {username: @user.username, email: @user.email, password: '    ', password_confirmation: '   '}}
    assert_select 'div.alert', 'Profile can not be updated for the moment.'
  end

  test "the show display either real name or user name" do
    log_in_as @user
    follow_redirect!
    assert_select 'h1', "Diota Tanara's Page"
    patch user_path(@user), params: { user: {username: @user.username, email: @user.email, password: 'password', password_confirmation: 'password', realname: ' '}}
    follow_redirect!
    assert_select 'h1', "didi's Page"
  end

  test "should be able to create new user" do
    assert_difference('User.count') do
      get new_user_url
      post users_url, params: { user: {username: 'james', email: 'james@doom.com', password: 'password', password_confirmation: 'password', realname: 'James Bond'}}
    end
    follow_redirect!
    assert_not flash.empty?
    assert_select 'div.alert', 'Welcome to No Magick Shop.'
  end

  test "should not be create with same username/email" do
    assert_difference('User.count', 0) do
      post users_url, params: { user: {username: @user.username, email: 'yadayada@yada.com', password: 'password', password_confirmation: 'password', realname: 'James Bond'}}
    end
    assert_not flash.empty?
    assert_select 'div.alert', 'Error in creating user, please try again later.'

    assert_difference('User.count', 0) do
      post users_url, params: { user: {username: 'yoda', email: @user.email, password: 'password', password_confirmation: 'password', realname: 'James Bond'}}
    end
    assert_not flash.empty?
    assert_select 'div.alert', 'Error in creating user, please try again later.'
  end


  test "should not be able to delete without log in" do
    assert_difference('User.count', 0) do
      delete user_url(@other)
    end
    follow_redirect!
    assert_select 'div.alert', 'Please log in.'
  end

  test "should not be able to delete other account" do
    assert_difference('User.count', 0) do
      log_in_as @user
      delete user_url(@other)
    end
    follow_redirect!
    assert_select 'div.alert', 'You are not allowed to be here'
  end

  test "should be able to delete own account" do
    assert_difference('User.count', -1) do
      log_in_as @user
      delete user_url(@user)
    end
    follow_redirect!
    assert_select 'div.alert', 'Thanks for your patronage.'
  end
end
