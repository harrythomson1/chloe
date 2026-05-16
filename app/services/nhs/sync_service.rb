module Nhs
  class SyncService
    def self.call
      url = 'https://api.service.nhs.uk/nhs-website-content/conditions/'
      Faraday.get(url) do |req|
        req.headers['apikey'] = Rails.application.credentials.nhs[:api_key]
      end
    end
  end
end
