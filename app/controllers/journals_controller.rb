class JournalsController < ApplicationController
  def index
    if current_user&.teacher
      @grades = Grade.order('number ASC, letter')
    elsif current_user&.parent
      @parent_students = Student.joins(:parent).where('parent_id': current_user)
    elsif current_user&.student
      redirect_to journal_path
    else
      redirect_to root_path
    end
  end

  def show
  end
end
