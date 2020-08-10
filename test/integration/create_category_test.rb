require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "admin", email: "admin@example.com", password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  test "create new category" do
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_url, params: { category: { name: "Sports"} }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "create new category and reject invalid submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_url, params: { category: { name: " "} }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end
end
