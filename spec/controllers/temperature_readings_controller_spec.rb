require 'rails_helper'

RSpec.describe TemperatureReadingsController do
  before(:all) do
    @temperature_readings_count = 10

    @temperature_readings_count.times do |i|
      TemperatureReading.create(sensor_name: "sensor_#{i}", degrees_celsius: 25.0 + i.to_d)
    end
  end

  after(:all) do
    TemperatureReading.destroy_all
  end

  context 'with a POST request' do
    context 'with valid parameters' do
      it 'creates a new temperature reading' do
        temperature_reading_params = {
            temperature_reading: {
                sensor_name: 'sensor_test',
                degrees_celsius: 25.7
            }
        }

        post :create, params: temperature_reading_params

        expect(response.code).to eq('200')
        expect(TemperatureReading.count).to eq @temperature_readings_count + 1

        created_reading = TemperatureReading.last

        expect(created_reading.sensor_name).to eq 'sensor_test'
        expect(created_reading.degrees_celsius).to eq 25.7
      end
    end

    context 'with invalid_parameters' do
      context 'such as a blank reading field' do
        it 'should render the error' do
          temperature_reading_params = {
              temperature_reading: {
                  sensor_name: 'sensor_test'
              }
          }

          post :create, params: temperature_reading_params
          expect(response.body).to include("can't be blank")
        end
      end

      context 'such as a blank sensor name field' do
        it 'should render the error' do
          temperature_reading_params = {
              temperature_reading: {
                  degrees_celsius: 25.4
              }
          }

          post :create, params: temperature_reading_params
          expect(response.body).to include("can't be blank")
        end
      end
    end
  end

  context 'with a GET request to /latest_reading' do
    it 'should return the most recent reading' do
      get :latest_reading

      expect(response.body).to include TemperatureReading.last.sensor_name
    end
  end

  context 'with a GET request to /' do
    it 'should return a list of the last 10 readings' do
      get :index

      TemperatureReading.limit(10) do |reading|
        expect(request.body).to include reading.sensor_name
      end
    end
  end
end
