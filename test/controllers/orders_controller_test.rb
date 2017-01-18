require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    get root_url
    @cart = Cart.find(session[:cart_id])
    @line_item = create(:line_item, cart: @cart)
    @order_without_user = create(:order)
    @older_order_with_user = create(:order, :ten_months_ago, user: @user)
    @user = create(:user)
    @order = create(:order, :paypal, user: @user)
    @other_user = create(:user, :random)
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should get show" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should be able to create new order" do
    post orders_url, params: {order: attributes_for(:order)}
    assert_response :redirect
  end

  test "should be able to copy line items from cart" do
    get new_order_url
    @cart.line_items.each do |a|
      assert_match "#{a.product.title}", response.body, 'Title'
      assert_includes response.body,"#{a.product.img_url}", 'Image Url'
      assert_includes response.body,"#{a.product.price.to_s}", 'Price'
    end

    assert_difference('Order.count') do
      post orders_url, params:{order: attributes_for(:order)}
      assert_response :redirect
    end
    follow_redirect!
    @cart.line_items.each do |a|
      assert_match a.product.title, response.body
      assert_includes response.body, a.product.img_url
      assert_includes response.body, a.product.price.to_s
    end
  end

  test "should be able to import information from user" do
    log_in_as(@user)
    get new_order_url
    assert_includes response.body, @user.realname
    assert_match @user.email, response.body
    assert_match @user.address, response.body
    assert_select 'form input#order_name[value=?]', @user.realname
    assert_select 'form input#order_email[value=?]', @user.email
    assert_select 'form textarea#order_address', @user.address
  end


  test "should not be able to create new order if cart is empty" do
    delete bye_url
    get new_order_url
    assert_response :redirect
    follow_redirect!
    assert_select 'div.alert', 'The Cart is Empty'
  end

  test "should not be able to create without required params" do
    assert_difference('Order.count', 0) do
      post orders_url, params:{order: attributes_for(:order, name: ' ')}
    end
    assert_select 'div.alert', 'Your order contains error'
  end

  test "should be able to delete/cancel the order" do
    assert_difference('Order.count', -1) do
      log_in_as(@user)
      delete order_url(@order)
    end
    assert_response :redirect
    assert_redirected_to user_url(@user)
    follow_redirect!
    assert_select 'div.alert', 'Your order history has been deleted'
  end

  test "should not be able to delete the shipped order" do
    assert_difference('Order.count', 0) do
      log_in_as(@user)
      get order_url(@older_order_with_user)
      delete order_url(@older_order_with_user)
    end
    follow_redirect!
    assert_select 'div.alert', 'Order has been shipped'
  end

  test "should not be able to delete other user's order" do
    assert_difference('Order.count', 0) do
      log_in_as(@other_user)
      delete order_url(@order)
    end
    assert_response :redirect
    follow_redirect!
    assert_select 'div.alert', "Error in deleting history"
  end

  test "should not be able to delete without any account" do
    assert_difference('Order.count', 0) do
      delete order_url(@order_without_user)
    end
    assert_response :redirect
    follow_redirect!
    assert_select 'div.alert', 'You need to have an account 1st'
  end

  test "should be able to see order status" do
    get order_url(@order)
    assert_select 'h1', 'Pending'
    get order_url(@older_order_with_user)
    assert_select 'h1', 'Shipped'
  end

  test "should destroy cart after create new order" do
    post orders_url, params:{order: attributes_for(:order)}
    assert session[:cart_id].nil?
  end

end
