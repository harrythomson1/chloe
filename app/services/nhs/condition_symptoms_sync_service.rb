module Nhs
  class ConditionSymptomsSyncService
    def self.call
      Faraday.new(request: { timeout: 60 }) do |f|
        f.headers['apikey'] = Rails.application.credentials.nhs[:api_key]
      end.get('https://api.service.nhs.uk/nhs-website-content/conditions/acanthosis-nigricans/')
    end
  end
end
