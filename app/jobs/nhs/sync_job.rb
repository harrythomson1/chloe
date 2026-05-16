module Nhs
  class SyncJob < ApplicationJob
    def perform
      Nhs::SyncService.call
    end
  end
end
