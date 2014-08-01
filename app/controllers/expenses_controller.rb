class ExpensesController < ApplicationController
  before_filter :find_expense, only: [:edit, :update, :destroy]

  def index
    @expenses = Expense.fetch_expenses(current_user, params)
    @users = User.select("id, first_name, last_name").where("id IN (?)", @expenses.map(&:user_id))
    @category_ids = @expenses.map(&:category_id).uniq
  end

  def new
    @expense = Expense.new(date: Date.today)
  end

  def create
    @expense = current_user.expenses.new(expense_params)
    @expense.group_id = current_user.group_id
    @expense.save
  end

  def show
    @expense = Expense.find_displayable_expense(params[:id], current_user)
  end

  def update
    @expense.update_attributes(expense_params)
  end

  def categorize
    @category = Category.find_by_id(params[:category_id])
    @expenses = Expense.for_category(params[:category_id], current_user)
  end

  private
    def find_expense
      @expense = Expense.find_editable_expense(params[:id], current_user)
      unless @expense
        flash[:alert] = "Expense not found"
        redirect_to "/expenses"
      end
    end

    def expense_params
      params.require(:expense).permit(:title, :description, :category_id, :cost, :date)
    end
end
