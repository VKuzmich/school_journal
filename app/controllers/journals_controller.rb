class JournalsController < ApplicationController
  before_action :authenticate_user!

  def index
    render_list_of_grades if current_user.teacher?
    render_list_of_students if current_user.parent?
    return redirect_to journal_path(id: student.grade.id) if current_user&.student
  end

  def show
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
