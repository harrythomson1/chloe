module Nhs
  module ApiClient
    def connection
      Faraday.new(request: { timeout: 60 }) do |f|
        f.headers['apikey'] = Rails.application.credentials.nhs[:api_key]
        f.request :json
        f.response :json
      end
    end
  end
end
