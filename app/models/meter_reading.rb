class MeterReading < ActiveRecord::Base
  attr_accessible :date, :reading

    # Validations
  validates :reading, :date, presence: true
  validates :reading, numericality: { greater_than_or_equal_to: 1, message: "should be a number and must be greater than or equal to 1" }, allow_blank: true
end
