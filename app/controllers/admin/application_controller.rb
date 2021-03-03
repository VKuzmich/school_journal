class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    return if current_user.try(:admin?)

    redirect_to '/', alert: 'Not authorized.'
  end
end
