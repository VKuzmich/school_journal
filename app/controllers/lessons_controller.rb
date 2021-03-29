class LessonsController < Admin::ApplicationController
  before_action :authenticate_teacher!
  before_action :set_lesson, only: %i[show edit update destroy]

  def index
    @lessons = Lesson.all
  end

  def show;  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      redirect_to lessons_path
    else
      render :new
    end

  end

  def edit;  end

  def update
    if @lesson.update(lesson_params)
      redirect_to @lesson
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy

    redirect_to lessons_path
  end

  private

  def authenticate_teacher!
    return if current_user&.teacher.user

    redirect_to root_path, alert: 'You are not allowed!'
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:home_task, :description, :date_at, :subject_id, :grade_id, :teacher_id)
  end
end
