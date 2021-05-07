class JournalsController < ApplicationController
  before_action :authenticate_user!

  def index
    return redirect_to journal_path(id: current_user.student.grade.id) if current_user.student?
    return render_list_of_students if current_user.parent?
    return render_list_of_grades if current_user.teacher?
  end

  def show
    @lessons = Lesson.where(date_at:  Date.current.beginning_of_week..Date.current.end_of_week,
                            grade_id: current_user.student.grade.id)
  end

  private

  def render_list_of_grades
    @grades = Grade.all
    render :list_of_grades
  end

  def render_list_of_students
    @students = current_user.parent.students
    render :list_of_students
  end
end
