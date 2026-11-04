private

  def set_question
    @question = Question.find(params[:id])
  end

  # ★ このメソッドを追加します
  def load_classroom_selection
    @grade = params[:grade]
    @classroom = params[:classroom]
    @subject_number = params[:subject] || params[:subject_number]

    return if @grade.blank? || @classroom.blank? || @subject_number.blank?

    grade_record = Grade.find_by(g_number: @grade)
    course_record = Course.find_by(c_number: @classroom)

    if grade_record && course_record
      @grade_course_subject = GradeCourseSubject.find_by(
        grade_id: grade_record.id,
        course_id: course_record.id,
        subject_id: @subject_number
      )
      @grade_course_subject_id = @grade_course_subject&.id
    end
  end

  # 保存を許可する項目
  def question_params
    params.require(:question).permit(
      :deadline,
      :q_content,
      :user_id,
      :grade_course_subject_id
    )
  end
