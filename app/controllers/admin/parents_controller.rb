class Admin::ParentsController < Admin::ApplicationController
  before_action :set_parent, only: %i[show edit update destroy]

  def index
    @parents = Parent.all
  end

  def show;  end

  def new
    @parent = Parent.new
  end

  def create
    @parent = Parent.new(parent_params)

    if @parent.save
      redirect_to admin_parents_path
    else
      render :new
    end

  end

  def edit;  end

  def update
    if @parent.update(parent_params)
      redirect_to [:admin, @parent]
    else
      render :edit
    end
  end

  def destroy
    @parent.destroy

    redirect_to admin_parents_path
  end

  private

  def set_parent
    @parent = Parent.find(params[:id])
  end

  def parent_params
    params.require(:parent).permit(:user_id)
  end
end
