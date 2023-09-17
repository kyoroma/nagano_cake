require "test_helper"

class Public::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_page" do
    get public_customers_my_page_url
    assert_response :success
  end

  test "should get edit" do
    get public_customers_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_customers_update_url
    assert_response :success
  end

  test "should get confirm_deactivation" do
    get public_customers_confirm_deactivation_url
    assert_response :success
  end

  test "should get deactivate" do
    get public_customers_deactivate_url
    assert_response :success
  end
end
