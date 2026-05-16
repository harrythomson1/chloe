module Nhs
  class ConditionsSyncJob < ApplicationJob
    def perform
      Nhs::SyncService.call(url: 'https://api.service.nhs.uk/nhs-website-content/conditions/', model: Condition)
    end
  end
end
