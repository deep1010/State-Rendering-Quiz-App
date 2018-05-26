require 'test_helper'

class DestroysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @destroy = destroys(:one)
  end

  test "should get index" do
    get destroys_url
    assert_response :success
  end

  test "should get new" do
    get new_destroy_url
    assert_response :success
  end

  test "should create destroy" do
    assert_difference('Destroy.count') do
      post destroys_url, params: { destroy: { Question: @destroy.Question } }
    end

    assert_redirected_to destroy_url(Destroy.last)
  end

  test "should show destroy" do
    get destroy_url(@destroy)
    assert_response :success
  end

  test "should get edit" do
    get edit_destroy_url(@destroy)
    assert_response :success
  end

  test "should update destroy" do
    patch destroy_url(@destroy), params: { destroy: { Question: @destroy.Question } }
    assert_redirected_to destroy_url(@destroy)
  end

  test "should destroy destroy" do
    assert_difference('Destroy.count', -1) do
      delete destroy_url(@destroy)
    end

    assert_redirected_to destroys_url
  end
end
