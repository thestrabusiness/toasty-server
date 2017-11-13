Rails.application.routes.draw do
  resources :temperature_readings, only: [:index, :create]
  get 'latest_reading', to: 'temperature_readings#latest_reading', as: :latest_temperature_reading
end
