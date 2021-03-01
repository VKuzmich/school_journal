class Admin::GradesController < Admin::ApplicationController
  before_action :set_grade, only: %i[show edit update destroy]

  def index
    @grades = Grade.all
  end

  def show; end

  def new
    @grade = Grade.new
  end

  def create
    @grade = Grade.new(grade_params)

    if @grade.save
      redirect_to admin_grades_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @grade.update(grade_params)
      redirect_to [:admin, @grade]
    else
      render 'edit'
    end
  end

  def destroy
    @grade.destroy

    redirect_to admin_grades_path
  end

  private

  def set_grade
    @grade = Grade.find(params[:id])
  end

  def grade_params
    params.require(:grade).permit(:number, :group)
  end
end
