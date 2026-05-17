module Nhs
  module ApiClient
    def connection
      Faraday.new(request: { timeout: 60 }) do |f|
        f.headers['apikey'] = Rails.application.credentials.nhs[:api_key]
      end
    end
  end
end
