class Admin::EventsController < Admin::BaseController
  respond_to :html
  inherit_resources

  protected
    def collection
      @events ||= end_of_association_chain.includes(:user, :group).order("created_at DESC").page(params[:page]).per(30)
    end

end
