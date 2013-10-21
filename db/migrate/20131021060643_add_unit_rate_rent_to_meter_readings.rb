class AddUnitRateRentToMeterReadings < ActiveRecord::Migration
  def change
    add_column :meter_readings, :rent, :int, default: 3500
    add_column :meter_readings, :unit_rate, :int, default: 8
    rename_table :meter_readings, :rent_details
    add_column :rent_details, :last_reading, :int
  end
end
