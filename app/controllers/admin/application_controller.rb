class Admin::ApplicationController < ApplicationController
  before_action :authorized?

  def index
    render json: {name: "David"}.to_json
  end

  private

  def authorized?
    return if user.admin?

    flash[:error] = t('admin.forbidden_error')
    redirect_to(root_path)
  end
end
