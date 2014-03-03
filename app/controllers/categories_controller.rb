class CategoriesController < ApplicationController
  before_filter :require_admin!, only: [:destroy]
  before_filter :find_category, only: [:edit, :update, :destroy, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
  end

  def update
    @category.update_attributes(category_params)
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: 'Category was successfully deleted.'
    else
      redirect_to categories_path, alert: 'Category could not be deleted.'
    end
  end

  def category_params
    params.require(:category).permit(:name, :is_expense, :is_personal_expense)
  end
end