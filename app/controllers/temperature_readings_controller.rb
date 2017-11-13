class TemperatureReadingsController < ApplicationController
  def index
    render json: TemperatureReading.limit(10)
  end

  def latest_reading
    render json: TemperatureReading.last
  end

  def create
    temperature_reading = TemperatureReading.new(temperature_reading_params)

    if temperature_reading.save
      render json: 201
    else
      render json: temperature_reading.errors, status: :bad_request
    end
  end

  private

  def temperature_reading_params
    params.require(:temperature_reading).permit(:sensor_name, :degrees_celsius)
  end
end
