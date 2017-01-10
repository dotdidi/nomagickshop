require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @item1 = line_items(:l1)
    @item2 = line_items(:l2)
    @cart = carts(:cart1)
  end

  test "should create Line_item" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { line_item: {add_quantity: '1', product_id: products(:titan).id}}
    end
    get cart_url(@cart)
    assert_select  'li.item', 'Titan Fall 2'
  end

  test "should delete Line item" do
    assert_difference('LineItem.count', -1) do
      delete line_item_path(@item1)
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?
    assert_select 'div.alert', 'Item successfully destroyed'
    get cart_url(@cart)
  end

  test "should be able to input quantity to add cart" do
    get products_url
    assert_select 'form input#line_item_add_quantity', { count: 3, value: '1'}
    get cart_url(@cart)
  end

  test "should be able to change and add quantity" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { line_item: {add_quantity: '1', product_id: products(:titan).id}}
      post line_items_url, params: { line_item: {add_quantity: '5', product_id: products(:titan).id}}
    end
    get cart_url(@cart)
    assert_select 'li.quantity', '6'
  end

end
