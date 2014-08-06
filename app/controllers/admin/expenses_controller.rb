class Admin::ExpensesController < Admin::BaseController
  respond_to :html
  inherit_resources

  protected
    def collection
      @expenses ||= end_of_association_chain.includes(:user, :category).order("created_at DESC").page(params[:page]).per(30)
    end

end
