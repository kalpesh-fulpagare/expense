class CreateMeterReadings < ActiveRecord::Migration
  def change
    create_table :meter_readings do |t|
      t.integer :reading
      t.date :date

      t.timestamps
    end
  end
end
