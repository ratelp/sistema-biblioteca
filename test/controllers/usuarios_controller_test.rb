require "test_helper"

class UsuariosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get usuarios_new_url
    assert_response :success
  end

  test "should get create" do
    get usuarios_create_url
    assert_response :success
  end
end
