require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:didi)
    @product = products(:titan)
    @update = { title: "Yahoo", 
               desc: "successfully create a product", 
               img_url: "https://s.yimg.com/dh/ap/default/130909/y_200_a.png", 
               price: "38.92" } 
  end

  test "should get index" do
    get products_url
    assert_response :success, "Root can not be accessed"
  end

  test "should get new" do
    get welcome_url
    post welcome_url, params: { session: {username: @user.username, password: 'password' }}
    get new_product_url
    assert_response :success, "New page can not be accessed"
  end

  test "should get edit" do
    get welcome_url
    post welcome_url, params: { session: {username: @user.username, password: 'password' }}
    get edit_product_url(@product)
    assert_response :success, "Edit page can not be accessed"
  end

  test "should get show" do
    get products_url(@product)
    assert_response :success, "Show can not be accessed"
  end

  test "can create a Product" do
    get welcome_url
    post welcome_url, params: { session: {username: @user.username, password: 'password' }}
    get new_product_url
    assert_response :success

    post "/products",
      params: { product: @update}
    assert_response :redirect
    follow_redirect!
    assert_response :success, "Product can not be created"
  end

  test "should be able to update product" do
    get welcome_url
    post welcome_url, params: { session: {username: @user.username, password: 'password' }}
    patch product_url(@product), params: { product: @update}
    assert_redirected_to product_url(@product), "Product can not be updated"
  end

  test "redirecting unauthorized personel to access some place" do
    delete bye_url
    get new_product_url
    assert_response :redirect, "Non-admin can access new product"
    get edit_product_url(@product)
    assert_response :redirect, "Non-admin can access edit product"
    patch product_url(@product), params: {product: @update}
    assert_response :redirect, "Non-admin can update the product"
  end

end
