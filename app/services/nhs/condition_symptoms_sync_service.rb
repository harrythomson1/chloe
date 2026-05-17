module Nhs
  class ConditionSymptomsSyncService
    def self.call
      Condition.find_each do |condition|
        Faraday.new(request: { timeout: 60 }) do |f|
          f.headers['apikey'] = Rails.application.credentials.nhs[:api_key]
        end.get(condition.source_url)
      end
    end
  end
end
