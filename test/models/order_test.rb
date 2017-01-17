require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = create(:order)
  end

  test "should be valid" do
    assert @order.valid?
  end

  test "name should be present" do
    @order.name = " "
    assert_not @order.valid?
  end

  test "email should be present" do
    @order.email = " "
    assert_not @order.valid?
  end

  test "address should be present" do
    @order.address = " "
    assert_not @order.valid?
  end

  test "pay type should be present" do
    @order.pay_type = " "
    assert_not @order.valid?
  end
end
