class Admin::TeachersController < Admin::ApplicationController

  def index
    @teachers = Teacher.all
  end

  def show

  end

  def new
    @teacher = Teacher.new
  end

  def create
    @subject = Subject.where(id: params[:subject_id])
    @teacher = Teacher.new(teacher_params)
    # @teacher.subject= @subject
    if @teacher.save
      redirect_to admin_teachers_path
    else
      render :new
    end

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
