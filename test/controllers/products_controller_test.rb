require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user, admin: true)
    @line_item = create(:line_item, :without_user)
    @product = @line_item.product
    @cart = @line_item.cart

    # list_items = create_list(:line_item, 3, cart: @cart, product: @product)
    @prodel = create(:product)
  end

  test "should get index" do
    get products_url
    assert_response :success, "Root can not be accessed"
  end

  test "should get new" do
    log_in_as @user
    get new_product_url
    assert_response :success, "New page can not be accessed"
  end

  test "should get edit" do
    log_in_as @user
    get edit_product_url(@product)
    assert_response :success, "Edit page can not be accessed"
  end

  test "should get show" do
    get products_url(@product)
    assert_response :success, "Show can not be accessed"
  end

  test "should be able to create a Product" do
    assert_difference('Product.count') do
      log_in_as @user
      post "/products", params: { product: attributes_for(:product)}
      assert_response :redirect
      follow_redirect!
      assert_select 'div.alert', 'Product has successfully created.'
    end
  end

  test "should not be able to create a Product without title/desc/img_url/price" do
    log_in_as @user
    follow_redirect!
    assert_difference('Product.count', 0) do
      post "/products", params: { product: {title: ' ', desc: 'a'*151, img_url: 'https://s.yimg.com/dh/ap/default/130909/y_200_a.png', price: '38.9'}}
      assert_select 'div#error_explanation li', "Title can't be blank"
    end
    assert_difference('Product.count', 0) do
      post "/products", params: { product: {title: 'Yahoo', desc: ' ', img_url: 'https://s.yimg.com/dh/ap/default/130909/y_200_a.png', price: '38.9'}}
      assert_select 'div#error_explanation li', "Desc can't be blank"
    end
    assert_difference('Product.count', 0) do
      post "/products", params: { product: {title: 'Yahoo', desc: 'a'*151, img_url: ' ', price: '38.9'}}
      assert_select 'div#error_explanation li', "Img url is invalid"
    end
    assert_difference('Product.count', 0) do
      post "/products", params: { product: {title: 'Yahoo', desc: 'a'*151, img_url: 'https://s.yimg.com/dh/ap/default/130909/y_200_a.png', price: ' '}}
      assert_select 'div#error_explanation li', "Price is not a number"
    end
  end

  test "should not be able to delete a Product associated with line items" do
    assert_difference('Product.count', 0) do
      log_in_as @user
      delete product_url(@product)
      assert_not flash.empty?
      follow_redirect!
      assert_select 'div.alert', 'Product can not be deleted.'
    end
  end

  test "should delete a Product" do
    assert_difference('Product.count', -1) do
      log_in_as @user
      delete product_url(@prodel)
      follow_redirect!
      assert_not flash.empty?
      assert_select 'div.alert', 'Product is deleted.'
    end
  end

  test "should be able to update product" do
    log_in_as @user
    patch product_url(@product), params: { product: attributes_for(:product)}
    assert_redirected_to product_url(@product)
    assert @product.title = "Yahoo"
    follow_redirect!
    assert_select 'div.alert', 'Product was updated.'
  end

  test "should not be able to update product without title / description / image url / price" do
    log_in_as @user
    follow_redirect!
    patch product_url(@product), params: { product: { title: '   ', desc: '   ', img_url: '   ', price: '   '}}
    assert_select 'div.alert', 'Product was failed to update.'
  end

  test "redirecting unauthorized personel to access some place" do
    delete bye_url
    get new_product_url
    assert_response :redirect, "Non-admin can access new product"
    get edit_product_url(@product)
    assert_response :redirect, "Non-admin can access edit product"
    patch product_url(@product), params: {product: attributes_for(:product)}
    assert_response :redirect, "Non-admin can update the product"
  end

end
