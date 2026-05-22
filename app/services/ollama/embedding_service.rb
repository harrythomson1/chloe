module Ollama
  class EmbeddingService
    class << self
      include Ollama::ApiClient

      def call(text:)
        client = connection
        client.post('/api/embeddings', { model: 'nomic-embed-text', prompt: text }).body['embedding']
      end
    end
  end
end
