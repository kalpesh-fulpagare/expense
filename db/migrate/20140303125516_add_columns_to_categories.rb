class AddColumnsToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :is_expense, :boolean, default: false
    add_column :categories, :is_personal_expense, :boolean, default: false
    Category.select("id, name, category_type").each do |category|
      if category.category_type == 'personal_exp'
        category.is_personal_expense = true
      else
        category.is_expense = true
      end
      category.save
    end

  end

  def self.down
    remove_column :categories, :is_personal_expense
    remove_column :categories, :is_expense
  end
end
