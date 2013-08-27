class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :title
      t.text :description
      t.integer :category_id
      t.integer :user_id
      t.decimal :cost
      t.integer :group_id
      t.date :date

      t.timestamps
    end
  end
end
