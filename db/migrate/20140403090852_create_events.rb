class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :participant_ids
      t.text :description
      t.date :date
      t.integer :total_cost
      t.integer :user_id
      t.integer :status, default: 0
      t.integer :group_id
      t.timestamps
    end
    add_index :events, :user_id
    add_index :events, :group_id
    add_index :events, :date
    add_index :events, :name
  end
end
