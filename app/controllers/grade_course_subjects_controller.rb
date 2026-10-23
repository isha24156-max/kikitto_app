class GradeCourseSubjectsController < ApplicationController
  before_action :set_grade_course_subject, only: %i[ show edit update destroy ]

  # GET /grade_course_subjects or /grade_course_subjects.json
  def index
    @grade_course_subjects = GradeCourseSubject.all
  end

  # GET /grade_course_subjects/1 or /grade_course_subjects/1.json
  def show
  end

  # GET /grade_course_subjects/new
  def new
    @grade_course_subject = GradeCourseSubject.new
  end

  # GET /grade_course_subjects/1/edit
  def edit
  end

  # POST /grade_course_subjects or /grade_course_subjects.json
  def create
    @grade_course_subject = GradeCourseSubject.new(grade_course_subject_params)

    respond_to do |format|
      if @grade_course_subject.save
        format.html { redirect_to @grade_course_subject, notice: "Grade course subject was successfully created." }
        format.json { render :show, status: :created, location: @grade_course_subject }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @grade_course_subject.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /grade_course_subjects/1 or /grade_course_subjects/1.json
  def update
    respond_to do |format|
      if @grade_course_subject.update(grade_course_subject_params)
        format.html { redirect_to @grade_course_subject, notice: "Grade course subject was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @grade_course_subject }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @grade_course_subject.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /grade_course_subjects/1 or /grade_course_subjects/1.json
  def destroy
    @grade_course_subject.destroy!

    respond_to do |format|
      format.html { redirect_to grade_course_subjects_path, notice: "Grade course subject was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade_course_subject
      @grade_course_subject = GradeCourseSubject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grade_course_subject_params
      params.require(:grade_course_subject).permit(:subject_id, :course_id, :grade_id)
    end
end
