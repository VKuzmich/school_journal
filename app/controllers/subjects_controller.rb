class SubjectsController < ApplicationController
  before_action :set_subject, only: %i[show edit update destroy]

  def index
    @subjects = Subject.all.order('created_at DESC')
  end

  def show; end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to @subject
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @subject.update(subject_params)
      redirect_to @subject
    else
      render 'edit'
    end
  end

  def destroy
    @subject.destroy

    redirect_to subjects_path
  end

  private

  def set_subject
    @subject = Subject.find_by(id: params[:id])
    raise ActiveRecord::RecordNotFound unless @subject
  end

  def subject_params
    params.require(:subject).permit(:name)
  end
end
