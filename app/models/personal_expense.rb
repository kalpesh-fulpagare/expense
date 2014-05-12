class PersonalExpense < ActiveRecord::Base
  attr_accessible :category_id, :cost, :date, :description, :title, :user_id

  # Validations
  validates :title, :category_id, :user_id, :cost, :date, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 1, message: "should be a number and must be greater than or equal to 1 Rs" }, allow_blank: true

  # Associations
  belongs_to :user
  belongs_to :category

  class << self
    def fetch_expenses(user)
      expenses = select("id, title, description, category_id, user_id, date, cost, MONTH(date) AS month")
      expenses = expenses.where("user_id = ?", user.id) unless user.is_admin
      expenses = expenses.where("date >= (DATE_FORMAT(CURDATE(), '%Y-%m-01') - INTERVAL 5 MONTH)").order("date DESC, updated_at DESC")
      expenses
    end
  end
end
