class DashboardsController < ApplicationController
  def show
    @expenses = Expense.dashboard_expenses(current_user)
    @users = User.select("id, first_name, last_name").where("id IN (?)", @expenses.map(&:user_id))
    @category_ids = @expenses.map(&:category_id)
    @dates = @expenses.map(&:date)
    @months = @expenses.map(&:month)
  end
end
