class JournalsController < ApplicationController
  before_action :authenticate_user!

  def index
    return redirect_to journal_path(id: current_user.student.grade.id) if current_user.student?
    return render_list_of_students if current_user.parent?
    return render_list_of_grades if current_user.teacher?
  end

  def show
    @lessons = Lesson.where(date_at: date_range, grade_id: params[:id])
    respond_to do |format|
      format.html
      format.js   { render :layout => false }
      format.json { render :json => {:message => "success"} }
    end

  end

  def teacher_add_lessons
    @teacher = current_user&.teacher
  end

  private

  def date_range
    Date.current.beginning_of_week..Date.current.end_of_week
  end

  def render_list_of_grades
    @grades = Grade.all
    render :list_of_grades
  end

  def render_list_of_students
    @students = current_user.parent.students
    render :list_of_students
  end
end
