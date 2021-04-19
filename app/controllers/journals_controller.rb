class JournalsController < ApplicationController
  before_action :authenticate_user!

  def index
    return redirect_to journal_path(id: student.grade.id) if current_user&.student
    render :list_of_grades if current_user&.teacher && teacher?
    render :list_of_students if current_user&.parent
  end

  def show
  end

  private

  def teacher?
    teacher.present?
  end
end
