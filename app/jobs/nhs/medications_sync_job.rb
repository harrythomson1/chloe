module Nhs
  class MedicationsSyncJob < ApplicationJob
    def perform
      Nhs::SyncService.call(url: 'https://api.service.nhs.uk/nhs-website-content/medicines/', model: Medication)
    end
  end
end
