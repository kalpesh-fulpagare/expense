class Expense < ActiveRecord::Base

  attr_accessible :category_id, :cost, :date, :description, :title, :user_id, :group_id

  # Validations
  validates :title, :category_id, :user_id, :cost, :date, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 1, message: "should be a number and must be greater than or equal to 1 Rs" }

  # Associations
  belongs_to :user
  belongs_to :group
  belongs_to :category

  class << self
    def fetch_expenses(user, params)
      expenses = select("id, title, description, category_id, user_id, date, cost").includes(:user).includes(:category)
      expenses = expenses.where("group_id = ?", user.group_id) if user.group_id.present?
      expenses = expenses.order("date DESC, updated_at DESC").page(params[:page]).per(50)
      expenses
    end

    def dashboard_expenses(user)
      expenses = select("id, title, description, category_id, user_id, date, cost").includes(:user).includes(:category)
      expenses = expenses.where("group_id = ?", user.group_id) if user.group_id.present?
      expenses = expenses.where("MONTH(date) = MONTH(CURRENT_DATE)").order("date DESC, updated_at DESC")
      expenses
    end

    def find_editable_expense(id, current_user)
      current_user.is_admin ? find_by_id(id) : current_user.expenses.find_by_id(id)
    end

    def find_displayable_expense(id, current_user)
      current_user.is_admin ? find_by_id(id) : find_by_id_and_group_id(id, current_user.group_id)
    end
  end

end
