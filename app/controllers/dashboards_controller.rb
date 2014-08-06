class DashboardsController < ApplicationController
  before_filter :require_no_admin!
  def show
    @expenses = Expense.dashboard_expenses(current_user)
    @users = User.select("id, first_name, last_name").where("id IN (?)", @expenses.map(&:user_id))
    @category_ids = @expenses.map(&:category_id).uniq
    @dates = @expenses.map(&:date).sort{ |x,y| y <=> x }.uniq
    @months = @expenses.map(&:month).uniq
  end
end
