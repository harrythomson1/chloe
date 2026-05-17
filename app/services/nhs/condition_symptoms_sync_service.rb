module Nhs
  class ConditionSymptomsSyncService
    class << self
      def call
        client = connection

        Condition.find_each do |condition|
          response = client.get(condition.source_url)
          symptoms_section = JSON.parse(response.body)['hasPart'].find { |part| part['hasHealthAspect'] == 'http://schema.org/SymptomsHealthAspect' }
          symptom = symptoms_section&.[]('description')
          condition.update!(symptoms: symptom) if symptom
        end
      end

      private

      def connection
        Faraday.new(request: { timeout: 60 }) do |f|
          f.headers['apikey'] = Rails.application.credentials.nhs[:api_key]
        end
      end
    end
  end
end
