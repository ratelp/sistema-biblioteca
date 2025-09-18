require "test_helper"

class BibliotecarioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bibliotecario_index_url
    assert_response :success
  end

  test "should get new" do
    get bibliotecario_new_url
    assert_response :success
  end

  test "should get create" do
    get bibliotecario_create_url
    assert_response :success
  end

  test "should get destroy" do
    get bibliotecario_destroy_url
    assert_response :success
  end
end
