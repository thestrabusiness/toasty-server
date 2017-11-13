class TemperatureReading < ApplicationRecord
  default_scope { order(created_at: :asc) }

  validates :sensor_name, presence: true
  validates :degrees_celsius, presence: true, numericality: true
end
