class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: t('admin.alert')
  end
end
