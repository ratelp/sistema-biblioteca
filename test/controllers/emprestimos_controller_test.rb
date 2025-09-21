require "test_helper"

class EmprestimosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get emprestimos_new_url
    assert_response :success
  end

  test "should get create" do
    get emprestimos_create_url
    assert_response :success
  end
end
