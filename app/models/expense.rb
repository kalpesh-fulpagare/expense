class Expense < ActiveRecord::Base
  attr_accessible :category_id, :cost, :date, :description, :title, :user_id
end
