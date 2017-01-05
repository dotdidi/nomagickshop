require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cart1 = carts(:one)
    @cart2 = carts(:two)
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

end
