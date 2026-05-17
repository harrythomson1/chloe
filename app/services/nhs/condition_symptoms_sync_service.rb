module Nhs
  class ConditionSymptomsSyncService
    class << self
      include Nhs::ApiClient

      def call
        client = connection

        Condition.find_each do |condition|
          response = client.get(condition.source_url)
          symptoms_section = JSON.parse(response.body)['hasPart'].find { |part| part['hasHealthAspect'] == 'http://schema.org/SymptomsHealthAspect' }
          symptom = symptoms_section&.[]('description')
          condition.update!(symptoms: symptom) if symptom
        end
      end
    end
  end
end
