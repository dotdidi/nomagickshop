require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest

  def setup
    get root_url
    @cart_without_user = Cart.find(session[:cart_id])
    @item1 = create(:line_item, cart: @cart_without_user)
    @product = create(:product)
    @product_inside_line_item = @item1.product

  end

  test "should create Line_item" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { line_item: {add_quantity: '1', product_id: @product.id}}
    end
    get cart_url(@cart_without_user)
    assert_select  'div.alert', 'Item added to the cart'
  end

  test "should delete Line item" do
    assert_difference('LineItem.count', -1) do
      delete line_item_path(@item1)
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?
    assert_select 'div.alert', 'Item successfully destroyed'
  end

  test "should be able to change the quantity inside the cart" do
    post line_items_url, params: { line_item: {add_quantity: '1', product_id: @product.id}}
    get cart_url(@cart_without_user)
    patch line_item_path(@item1), params: {line_item: {add_quantity: '9', product_id: @product_inside_line_item.id}}
    follow_redirect!
    assert_select 'div.alert-success', 'Item cart updated'
    assert_select "form input[value=?]", '9'
    patch line_item_path(@item1), params: {line_item: {add_quantity: '0', product_id: @product_inside_line_item.id}}
    follow_redirect!
    assert_select 'div.alert-error', 'Item failed to update'
    assert_select "form input[value=?]", '9'
  end

  test "should be able to input quantity to add cart" do
    get products_url
    assert_select 'form input#line_item_add_quantity', { count: 5, value: '1'}
    get cart_url(@cart_without_user)
    assert_select 'form input#line_item_add_quantity', { count: 1, value: '1'}
  end

  test "should be able to change and add quantity" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { line_item: {add_quantity: '1', product_id: @product.id}}
      post line_items_url, params: { line_item: {add_quantity: '5', product_id: @product.id}}
    end
    get cart_url(@cart_without_user)
    assert_select "form input[value=?]", '6'
  end

end
