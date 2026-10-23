require "application_system_test_case"

class GradeCourseSubjectsTest < ApplicationSystemTestCase
  setup do
    @grade_course_subject = grade_course_subjects(:one)
  end

  test "visiting the index" do
    visit grade_course_subjects_url
    assert_selector "h1", text: "Grade course subjects"
  end

  test "should create grade course subject" do
    visit grade_course_subjects_url
    click_on "New grade course subject"

    fill_in "Course", with: @grade_course_subject.course_id
    fill_in "Grade", with: @grade_course_subject.grade_id
    fill_in "Subject", with: @grade_course_subject.subject_id
    click_on "Create Grade course subject"

    assert_text "Grade course subject was successfully created"
    click_on "Back"
  end

  test "should update Grade course subject" do
    visit grade_course_subject_url(@grade_course_subject)
    click_on "Edit this grade course subject", match: :first

    fill_in "Course", with: @grade_course_subject.course_id
    fill_in "Grade", with: @grade_course_subject.grade_id
    fill_in "Subject", with: @grade_course_subject.subject_id
    click_on "Update Grade course subject"

    assert_text "Grade course subject was successfully updated"
    click_on "Back"
  end

  test "should destroy Grade course subject" do
    visit grade_course_subject_url(@grade_course_subject)
    click_on "Destroy this grade course subject", match: :first

    assert_text "Grade course subject was successfully destroyed"
  end
end
