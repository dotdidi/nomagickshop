require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cart1 = carts(:cart1)
    @cart2 = carts(:cart2)
    @user = users(:jasper)
  end


  test "should get show" do
    get cart_url(@cart1)
    assert_response :success
  end

  test "Cart is always there" do
  end

  test "should be able to empty cart" do
    # get cart_url(@cart1)
    # puts response.body
  end

  test "cart should attach to the user" do
  end

  test "should be able to see the quantity for each product" do
  end

  test "should be able to change the existing quantity" do
  end

  test "should merge the same product in quantity" do
  end

end
