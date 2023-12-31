require "test_helper"

class Public::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_orders_new_url
    assert_response :success
  end

  test "should get confirm_order" do
    get public_orders_confirm_order_url
    assert_response :success
  end

  test "should get order_completed" do
    get public_orders_order_completed_url
    assert_response :success
  end

  test "should get place_order" do
    get public_orders_place_order_url
    assert_response :success
  end

  test "should get index" do
    get public_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get public_orders_show_url
    assert_response :success
  end
end
