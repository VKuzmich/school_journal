class Admin::TeachersController < Admin::ApplicationController

  def index
    @teachers = Teacher.all
  end

  def show

  end

  def new
  end

  def edit
  end

  private

  def teacher_params
    params.require(:teacher).permit(:user_id, :subject_id)
  end
end
