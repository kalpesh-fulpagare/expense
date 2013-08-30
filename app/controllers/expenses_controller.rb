class ExpensesController < ApplicationController
  before_filter :find_expense, only: [:edit, :update, :destroy]

  def index
    @expenses = Expense.fetch_expenses(current_user, params)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.new(expense_params)
    @expense.group_id = current_user.group_id
    if @expense.save
      redirect_to edit_expense_path(@expense), notice: 'Expense was successfully created.'
    else
      render action: "new"
    end
  end

  def show
    @expense = Expense.find_displayable_expense(params[:id], current_user)
  end

  def update
    if @expense.update_attributes(expense_params)
      redirect_to edit_expense_path(@expense), notice: 'Expense was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    if @expense.destroy
      redirect_to expenses_url, notice: "Expense deleted successfully."
    else
      redirect_to expenses_url, notice: "Expense could not be deleted, please try after some time."
    end
  end

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
