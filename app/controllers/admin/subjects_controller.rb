class Admin::SubjectsController < Admin::ApplicationController
  before_action :set_subject, only: %i[show edit update destroy]

  def index
    @subjects = Subject.all
  end

  def show; end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @subject.update(subject_params)
      redirect_to [:admin, @subject]
    else
      render 'edit'
    end
  end

  def destroy
    @subject.destroy

    redirect_to admin_subjects_path
  end

  private

   def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name)
  end
end