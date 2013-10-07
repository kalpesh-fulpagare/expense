class MeterReadingsController < ApplicationController
  before_filter :find_meter_reading, only: [:edit, :update, :destroy]

  def index
    @meter_readings = MeterReading.limit(20)
  end


  def new
    @meter_reading = MeterReading.new
  end

  def create
    @meter_reading = MeterReading.new(meter_reading_params)
    if @meter_reading.save
      redirect_to meter_readinga_path, notice: 'Meter reading was successfully created.'
    else
      render action: "new"
    end
  end


  def update
    if @meter_reading.update_attributes(meter_reading_params)
      redirect_to meter_readings_path, notice: 'Meter reading was successfully updated.'
    else
      render action: "edit"
    end
  end


  def destroy
    @meter_reading = MeterReading.find(params[:id])
    @meter_reading.destroy
    redirect_to meter_readings_url
  end

  private

    def meter_reading_params
      params.require(:meter_reading).permit(:date, :reading)
    end
end
