require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    get root_url
    @cart = Cart.find(session[:cart_id])
    @user = create(:user)
    @order = create(:order, user: @user)
    @line_item = create(:line_item, cart: @cart, order_id: @order.id)
  end

  test "should get new" do
    get new_transaction_url
    assert_response :success
  end

  test "should get show" do
    # get show_transaction_url(@transaction)
    # assert_response :success
  end

  test "should be able to create transaction" do
    assert_difference('Transaction.count') do
      post transactions_url, params:{transaction: attributes_for(:transaction, order: @order)}
    end
    follow_redirect!
    assert_select 'div.alert', 'Success!'
  end

  test "should not be able to create with invalid card" do
    assert_difference('Transaction.count', 0) do
      post transactions_url, params:{transaction: attributes_for(:transaction, :invalid_card, order: @order)}
      assert_response :success, 'invalid_card'
      assert_includes response.body, 'not a valid credit card number'
    end

    assert_difference('Transaction.count', 0) do
      post transactions_url, params:{transaction: attributes_for(:transaction, :expires, order:@order)}
      assert_response :success, 'Year expired'
      assert_includes response.body, 'Year expired', 'Year expired'
    end
  end

  test "should destroy cart after create new transaction" do
    post transactions_url, params:{transaction: attributes_for(:transaction, order: @order)}
    assert session[:cart_id].nil?
  end

  test "order's shipment is scheaduled when transaction is completed" do
    assert_difference('Delayed::Job.count') do
      post transactions_url, params:{transaction: attributes_for(:transaction, order: @order)}
    end
  end
end
