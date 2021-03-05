class Admin::TeachersController < Admin::ApplicationController

  def index
    @teachers = User.joins(:teacher)
  end

  def show

  end

  def new
    @teacher = Teacher.new
  end

  def creare
    @teacher = Teacher.new(teacher_params)


  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to [:admin, @teacher]
    else
      render :edit
    end
  end

  private

  def set_teacher
    @subject = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:user_id, :subject_id)
  end
end
