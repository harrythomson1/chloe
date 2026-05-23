module Ollama
  class ConditionsEmbeddingService
    def self.call
      Condition.find_each do |condition|
        embedding = Ollama::EmbeddingService.call(text: 'any text')
        condition.update!(embedding: embedding)
      end
    end
  end
end
