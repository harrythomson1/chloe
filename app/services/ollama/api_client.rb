module Ollama
  module ApiClient
    def connection
      Faraday.new(url: ENV.fetch('OLLAMA_HOST', 'http://localhost:11434'), request: { timeout: 300 }) do |f|
        f.request :json
        f.response :json
      end
    end
  end
end
