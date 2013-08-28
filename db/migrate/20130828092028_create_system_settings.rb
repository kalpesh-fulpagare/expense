class CreateSystemSettings < ActiveRecord::Migration
  def up
    create_table :system_settings do |t|
      t.string :name
      t.text :value
    end
  end

  def down
    drop_table :system_settings
  end
end
