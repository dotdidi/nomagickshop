require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @item1 = line_items(:one)
    @item2 = line_items(:two)
    @cart = carts(:one)
  end

  test "should create Line_item" do
    assert_difference('LineItem.count') do
      post line_items_url, params: {product_id: products(:titan).id}
    end
    get cart_url(@cart)
    assert_select  'li.item', 'Titan Fall 2'
  end

  test "should delete Line item" do
    assert_difference('LineItem.count', -1) do
      delete line_item_path(@item1)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
    get cart_url(@cart)
  end

end
