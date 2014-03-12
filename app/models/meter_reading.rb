class MeterReading < ActiveRecord::Base
  attr_accessible :date, :reading, :unit_rate, :rent, :last_reading
  self.table_name = "rent_details"

  # Validations
  validates :reading, :date, :last_reading, :rent, presence: true
  validates :reading, :last_reading, :rent, :unit_rate, numericality: { greater_than_or_equal_to: 1, message: "should be a number and must be greater than or equal to 1" }, allow_blank: true

  def last_meter_reading
    self.new_record? ? MeterReading.last.try(:reading) : self.last_reading
  end
end
