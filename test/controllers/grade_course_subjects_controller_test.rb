require "test_helper"

class GradeCourseSubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grade_course_subject = grade_course_subjects(:one)
  end

  test "should get index" do
    get grade_course_subjects_url
    assert_response :success
  end

  test "should get new" do
    get new_grade_course_subject_url
    assert_response :success
  end

  test "should create grade_course_subject" do
    assert_difference("GradeCourseSubject.count") do
      post grade_course_subjects_url, params: { grade_course_subject: { course_id: @grade_course_subject.course_id, grade_id: @grade_course_subject.grade_id, subject_id: @grade_course_subject.subject_id } }
    end

    assert_redirected_to grade_course_subject_url(GradeCourseSubject.last)
  end

  test "should show grade_course_subject" do
    get grade_course_subject_url(@grade_course_subject)
    assert_response :success
  end

  test "should get edit" do
    get edit_grade_course_subject_url(@grade_course_subject)
    assert_response :success
  end

  test "should update grade_course_subject" do
    patch grade_course_subject_url(@grade_course_subject), params: { grade_course_subject: { course_id: @grade_course_subject.course_id, grade_id: @grade_course_subject.grade_id, subject_id: @grade_course_subject.subject_id } }
    assert_redirected_to grade_course_subject_url(@grade_course_subject)
  end

  test "should destroy grade_course_subject" do
    assert_difference("GradeCourseSubject.count", -1) do
      delete grade_course_subject_url(@grade_course_subject)
    end

    assert_redirected_to grade_course_subjects_url
  end
end
