require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @cart1 = create(:cart)
    @product = create(:product)
    @other = create(:user, username: 'vince', realname: 'Vince Falentine')
  end


  test "should get show" do
    get cart_url(@cart1)
    assert_response :success
  end

  test "Cart is always there" do
    log_in_as @user
    assert session[:cart_id].present?
    delete bye_url
    get products_url
    assert session[:cart_id].present?
  end

  test "should be able to empty cart" do
    assert_difference('LineItem.count', 0) do
      post line_items_url, params: { line_item: {add_quantity: '1', product_id: create(:product).id}}
      post line_items_url, params: { line_item: {add_quantity: '1', product_id: create(:product).id}}
      post line_items_url, params: { line_item: {add_quantity: '1', product_id: create(:product).id}}
      get cart_url(session[:cart_id])
      assert_select 'header li', 'Empty your cart'
      delete cart_url(session[:cart_id])
    end
  end

  test "cart should attach to the user" do
    log_in_as @other
    get products_url
    assert_includes @other.carts.ids, session[:cart_id]
    assert_not_includes @user.carts.ids, session[:cart_id]
  end

  test "cart can be there without user" do
    log_in_as @other
    get products_url
    assert_includes @other.carts.ids, session[:cart_id]
    assert_not_includes @user.carts.ids, session[:cart_id]
    delete bye_url
    follow_redirect!
    assert_not_includes @other.carts.ids, session[:cart_id]
  end

  test "should be able to change the existing quantity" do
  end

  test "should merge the same product in quantity" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { line_item: {add_quantity: '1', product_id: @product.id}}
      post line_items_url, params: { line_item: {add_quantity: '5', product_id: @product.id}}
      post line_items_url, params: { line_item: {add_quantity: '12', product_id: @product.id}}
      post line_items_url, params: { line_item: {add_quantity: '1', product_id: @product.id}}
    end
  end
end
