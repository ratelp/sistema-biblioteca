require "test_helper"

class CategoriaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @categorium = categoria(:one)
  end

  test "should get index" do
    get categoria_url
    assert_response :success
  end

  test "should get new" do
    get new_categorium_url
    assert_response :success
  end

  test "should create categorium" do
    assert_difference("Categorium.count") do
      post categoria_url, params: { categorium: { nome: @categorium.nome } }
    end

    assert_redirected_to categorium_url(Categorium.last)
  end

  test "should show categorium" do
    get categorium_url(@categorium)
    assert_response :success
  end

  test "should get edit" do
    get edit_categorium_url(@categorium)
    assert_response :success
  end

  test "should update categorium" do
    patch categorium_url(@categorium), params: { categorium: { nome: @categorium.nome } }
    assert_redirected_to categorium_url(@categorium)
  end

  test "should destroy categorium" do
    assert_difference("Categorium.count", -1) do
      delete categorium_url(@categorium)
    end

    assert_redirected_to categoria_url
  end
end
