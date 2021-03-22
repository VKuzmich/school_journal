class Admin::StudentsController < Admin::ApplicationController
  before_action :set_student, only: %i[show edit update destroy]

  def index
    @students = Student.all
  end

  def show;  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to admin_students_path
    else
      render :new
    end

  end

  def edit;  end

  def update
    if @student.update(student_params)
      redirect_to [:admin, @student]
    else
      render :edit
    end
  end

  def destroy
    @student.destroy

    redirect_to admin_students_path
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:birthday, :user_id, :parent_id, :grade_id )
  end
end
