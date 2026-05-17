module Nhs
  class ConditionSymptomsSyncService
    class << self
      include Nhs::ApiClient

      def call
        client = connection

        Condition.find_each do |condition|
          Rails.logger.debug { "Updating symptoms for #{condition.name}" }
          find_and_update_condition(condition, client)
          sleep(0.5)
        rescue StandardError => e
          Rails.logger.error("Failed to sync symptoms for #{condition.name}: #{e.message}")
        end
      end

      private

      def find_and_update_condition(condition, client)
        response = client.get(condition.source_url)
        symptoms_section = JSON.parse(response.body)['hasPart'].find { |part| part['hasHealthAspect'] == 'http://schema.org/SymptomsHealthAspect' }
        symptom = symptoms_section&.[]('description')
        condition.update!(symptoms: symptom) if symptom
      end
    end
  end
end
