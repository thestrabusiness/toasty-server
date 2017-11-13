class CreateTemperatureReadings < ActiveRecord::Migration[5.1]
  def change
    create_table :temperature_readings do |t|
      t.string :sensor_name, null: false, index: true
      t.decimal :degrees_celsius, null: false
      t.timestamps
    end
  end
end
