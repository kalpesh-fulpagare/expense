class Admin::UsersController < Admin::BaseController
  respond_to :html
  inherit_resources

  def update_profile
    if current_user.update_with_password(params[:user].permit(:current_password, :password, :password_confirmation))
      redirect_to admin_expenses_path, notice: 'Password Changed successfully!'
      sign_in current_user, bypass: true
    else
      render "edit"
    end
  end

  protected
    def collection
      @users ||= end_of_association_chain.where("is_admin = ?", false).order("created_at DESC").page(params[:page]).per(30)
    end
end