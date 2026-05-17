module Nhs
  class ConditionSymptomsSyncJob < ApplicationJob
    def perform
      Nhs::ConditionSymptomsSyncService.call
    end
  end
end
