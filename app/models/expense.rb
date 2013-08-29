class Expense < ActiveRecord::Base
  attr_accessible :category_id, :cost, :date, :description, :title, :user_id, :group_id

  # Validations
  validates :title, :category_id, :user_id, :cost, :date, presence: true
  validates :cost, numericality: { greater_than_or_equal_to: 1, message: "must be greater than or equal to 1 Rs" }

  # Associations
  belongs_to :user
  belongs_to :group
  belongs_to :category
end
