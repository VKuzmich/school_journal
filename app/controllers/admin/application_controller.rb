class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def authenticate_admin
    redirect_to '/', alert: 'Not authorized.' unless current_user && admin_access
  end

  private

  def admin_access
    current_user.try(:admin?)
  end
end
