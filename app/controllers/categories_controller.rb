class CategoriesController < ApplicationController
  before_filter :require_admin!, only: [:destroy]
  before_filter :find_category, only: [:edit, :update, :destroy, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: 'Category was successfully deleted.'
    else
      redirect_to categories_path, alert: 'Category could not be deleted.'
    end
  end
end