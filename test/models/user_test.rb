require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:didi)
  end

  test "should be valid" do
    assert @user.valid?, "User not valid"
  end

  test "name should be present" do
    @user.username = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

end
