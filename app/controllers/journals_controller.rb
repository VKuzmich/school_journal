class JournalsController < ApplicationController
  def index
    if current_user&.teacher
      @grades = Grade.order('number ASC, letter')
    elsif current_user&.parent
      @parent_students = Student.joins(:parent).where('parent_id': current_user)
    elsif current_user&.student
      redirect_to journal_path(:id)
    else
      redirect_to new_user_session_path
    end
  end

  def show
  end
end
