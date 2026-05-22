module Ollama
  class Error < StandardError; end

  class EmbeddingService
    class << self
      include Ollama::ApiClient

      def call(text:)
        client = connection
        response = client.post('/api/embeddings', { model: 'nomic-embed-text', prompt: text })
        raise Ollama::Error, "Unexpected status: #{response.status}" if response.status != 200

        response.body['embedding']
      end
    end
  end
end
