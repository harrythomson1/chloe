module Ollama
  class ConditionsEmbeddingServiceJob < ApplicationJob
    def perform
      Ollama::ConditionsEmbeddingService.call
    end
  end
end
