class AddIndicesToExpenses < ActiveRecord::Migration
  def change
    add_index :expenses, :user_id
    add_index :expenses, :category_id
    add_index :expenses, :title
    add_index :expenses, :date
    add_index :personal_expenses, :user_id
    add_index :personal_expenses, :category_id
    add_index :personal_expenses, :title
    add_index :personal_expenses, :date
  end
end
