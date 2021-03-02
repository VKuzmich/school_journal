class Admin::ApplicationController < ApplicationController
  before_action :authorized?

  private

  def authorized?
    return if current_user.try(:admin?)

    flash[:error] = t('admin.forbidden_error')
    redirect_to(root_path)
  end
end
