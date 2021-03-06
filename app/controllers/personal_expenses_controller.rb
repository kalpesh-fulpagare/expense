class PersonalExpensesController < ApplicationController
  before_filter :find_personal_expense, only: [:edit, :update, :destroy, :show]
  before_filter :require_no_admin!

  def index
    @personal_expenses = PersonalExpense.fetch_expenses(current_user)
    @category_ids = @personal_expenses.map(&:category_id).uniq
    @dates = @personal_expenses.map(&:date).sort{ |x,y| y <=> x }.uniq
    @months = @personal_expenses.map(&:month).uniq
  end

  def new
    @personal_expense = PersonalExpense.new(date: Date.today)
  end

  def create
    @personal_expense = current_user.personal_expenses.new(personal_expense_params)
    @personal_expense.save
  end

  def update
    @personal_expense.update_attributes(personal_expense_params)
  end

  def destroy
    if @personal_expense.destroy
      redirect_to personal_expenses_url, notice: "Personal Expense deleted successfully."
    else
      redirect_to personal_expenses_url, notice: "Personal Expense could not be deleted, please try after some time."
    end
  end

  def categorize
    @category = Category.find_by_id(params[:category_id])
    @personal_expenses = PersonalExpense.for_category(params[:category_id], current_user)
  end

  private

  def personal_expense_params
    params.require(:personal_expense).permit(:title, :description, :category_id, :cost, :date)
  end

  def find_personal_expense
    @personal_expense = PersonalExpense.find_by_id_and_user_id(params[:id], current_user.id)
  end
end
