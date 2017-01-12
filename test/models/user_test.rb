require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create :user
  end

  test "should be valid" do
    assert @user.valid?, "User not valid"
  end

  test "name should be present" do
    @user.username = "    "
    assert_not @user.valid?
  end

  test "username should not be to short" do
    @user.username = "a" *3
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = "    "
    assert_not @user.valid?
  end

  test "password should be not to short" do
    @user.password = "a" *5
    assert_not @user.valid?
  end

  test "realname should not be too long" do
    @user.realname = "a" *51
    assert_not @user.valid?
  end

  test "realname could be nil" do
    @user.realname = "  "
    assert @user.valid?
  end

  test "addres should not be to short" do
    @user.address = "a" *3
    assert_not @user.valid?
  end

  test "addres could be nil" do
    @user.address = "   "
    assert @user.valid?
  end

  test "phone should be consisted of number" do
    @user.phone = "abcdefgh"
    assert_not @user.valid?
  end

  test "phone should not be too short" do
    @user.phone = "1" *6
    assert_not @user.valid?
  end

  test "phone should not be too long" do
    @user.phone = "5" *15
    assert_not @user.valid?
  end

  test "phone could be nil" do
    @user.phone = "   "
    assert @user.valid?
  end

end
