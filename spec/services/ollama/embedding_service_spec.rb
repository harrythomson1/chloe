require 'rails_helper'
RSpec.describe Ollama::EmbeddingService do
  describe '.call' do
    it 'returns an array of 768 floats' do
      stub_request(:post, 'http://localhost:11434/api/embeddings')
        .to_return(
          status: 200,
          body: { embedding: Array.new(768) { rand } }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      result = described_class.call(text: 'I have a shortness of breath')
      expect(result.length).to eq(768)
      expect(result).to all(be_a(Float))
    end
  end
end
