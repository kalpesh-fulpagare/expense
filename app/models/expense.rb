class Expense < ActiveRecord::Base

  attr_accessible :category_id, :cost, :date, :description, :title, :user_id, :group_id

  # Validations
  validates :title, :category_id, :user_id, :cost, :date, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 1, message: "should be a number and must be greater than or equal to 1 Rs" }, allow_blank: true

  # Associations
  belongs_to :user
  belongs_to :group
  belongs_to :category

  class << self
    def fetch_expenses(user, params)
      expenses = select("id, title, description, category_id, user_id, date, cost")
      expenses = expenses.where(group_id: user.group_id) if user.group_id.present?
      expenses = expenses.where(category_id: params[:category_ids]) if params[:category_ids].present?
      expenses = expenses.where(user_id: params[:user_ids]) if params[:user_ids].present?
      expenses = expenses.where(date: params[:date].to_date) if params[:date].present?
      expenses = expenses.where("title LIKE ?", "%" + params[:title] + "%") if params[:title].present?
      expenses = expenses.where("description LIKE ?", "%" + params[:description] + "%") if params[:description].present?
      expenses = expenses.where("date >= ?", params[:from_date].to_date) if params[:from_date].present?
      expenses = expenses.where("date <= ?", params[:to_date].to_date) if params[:to_date].present?
      expenses = expenses.order("date DESC, updated_at DESC").page(params[:page]).per(30)
      expenses
    end

    def dashboard_expenses(user)
      expenses = select("id, title, description, category_id, user_id, date, cost, MONTH(date) AS month")
      expenses = expenses.where("group_id = ?", user.group_id) if user.group_id.present?
      expenses = expenses.where("date >= (DATE_FORMAT(CURDATE(), '%Y-%m-01') - INTERVAL 1 MONTH)").order("date DESC, updated_at DESC")
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
