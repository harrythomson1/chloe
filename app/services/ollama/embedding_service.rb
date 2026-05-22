module Ollama
  class EmbeddingService
    def self.call(text:)
      Array.new(768) { rand }
    end
  end
end
