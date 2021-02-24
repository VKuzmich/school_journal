class Admin::ApplicationController
  before_action :authorized?

  private

  def authorized?
    return if user.admin?

    flash[:error] = t('controllers.admin.authorized?.flash.error')
    redirect_to(root_path)
  end
end
