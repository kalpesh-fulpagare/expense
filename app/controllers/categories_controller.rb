class CategoriesController < ApplicationController
  before_filter :find_category, only: [:edit, :update, :show]
  before_filter :require_no_admin!

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(category_params)
    @category.save
  end

  def update
    @category.update_attributes(category_params)
  end

  private
  def category_params
    params.require(:category).permit(:name, :is_expense, :is_personal_expense)
  end
end