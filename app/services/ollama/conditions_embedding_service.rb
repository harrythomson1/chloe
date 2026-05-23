module Ollama
  class ConditionsEmbeddingService
    def self.call
      Ollama::EmbeddingService.call(text: 'any text')
    end
  end
end
