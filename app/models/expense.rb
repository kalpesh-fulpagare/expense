class Expense < ActiveRecord::Base
  attr_accessible :category_id, :cost, :date, :description, :title, :user_id, :group_id
  validates :title, :category_id, :user_id, :cost, :date, presence: true

  # Validations
  belongs_to :user
  belongs_to :group
  belongs_to :category
end
