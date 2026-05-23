module Ollama
  class ConditionsEmbeddingService
    def self.call
      Condition.find_each do |condition|
        embedding = Ollama::EmbeddingService.call(
          text: "#{condition.name} #{condition.description} #{condition.symptoms}"
        )
        condition.update!(embedding: embedding)
      end
    end
  end
end
