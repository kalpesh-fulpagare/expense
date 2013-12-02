class MeterReadingsController < ApplicationController
  before_filter :find_meter_reading, only: [:edit, :update, :destroy]

  def index
    @meter_readings = MeterReading.limit(5).order("created_at DESC")
  end


  def new
    @meter_reading = MeterReading.new
  end

  def create
    @meter_reading = MeterReading.new(meter_reading_params)
    @meter_reading.save
  end


  def update
    @meter_reading.update_attributes(meter_reading_params)
  end


  def destroy
    @meter_reading = MeterReading.find(params[:id])
    @meter_reading.destroy
    redirect_to meter_readings_url
  end

  private

    def meter_reading_params
      params.require(:meter_reading).permit(:date, :reading, :rent, :unit_rate, :last_reading)
    end
end
