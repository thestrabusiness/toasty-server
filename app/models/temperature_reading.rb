class TemperatureReading < ApplicationRecord
  validates :sensor_name, presence: true
  validates :degrees_celsius, presence: true, numericality: true
end
