# config/initializers/load_api_key.rb
ENV['API_KEY'] ||= Rails.application.credentials.dig(:rapidapi, :key)
