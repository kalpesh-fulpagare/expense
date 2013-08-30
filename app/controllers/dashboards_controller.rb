class DashboardsController < ApplicationController
  def show
    @expenses = Expense.dashboard_expenses(current_user)

  end
end
