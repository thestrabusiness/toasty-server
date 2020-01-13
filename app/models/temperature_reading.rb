class TemperatureReading < ApplicationRecord
  validates :sensor_name, presence: true
  validates :degrees_celsius, presence: true, numericality: true

  def degrees_fahrenheit
    degrees_celsius * 9/5 + 32
  end
end
