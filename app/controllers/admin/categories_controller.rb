class Admin::CategoriesController < Admin::BaseController
  respond_to :html
  inherit_resources
  def create
    @category = current_user.categories.new(params[:category])
    create! { admin_categories_url }
  end

  def update
    update! { admin_categories_url }
  end
end
