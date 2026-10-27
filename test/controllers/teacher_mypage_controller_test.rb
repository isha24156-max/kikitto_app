require "test_helper"

class TeacherMypageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teacher_mypage_index_url
    assert_response :success
  end
end
