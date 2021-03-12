class Admin::TeachersController < Admin::ApplicationController
  before_action :set_teacher, only: %i[show edit update destroy]

  def index
    @teachers = Teacher.all
  end

  def show;  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
                             # .merge(user_id: current_user.id))
    if @teacher.save
      redirect_to admin_teachers_path
    else
      render :new
    end

  end

  def edit;  end

  def update
    if @teacher.update(teacher_params)
      redirect_to [:admin, @teacher]
    else
      render :edit
    end
  end

  def destroy
    @teacher.destroy

    redirect_to admin_teachers_path
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:user_id, :subject_id)
  end
end
