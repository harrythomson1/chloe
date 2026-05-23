require 'rails_helper'

RSpec.describe Ollama::ConditionsEmbeddingService do
  describe '.call' do
    let!(:condition) { create(:condition) }
    let(:fake_embedding) { Array.new(768) { rand } }

    it 'makes a call to the embedding service' do
      allow(Ollama::EmbeddingService).to receive(:call)
      described_class.call
      expect(Ollama::EmbeddingService).to have_received(:call)
    end

    it 'adds vectors to one condition' do
      allow(Ollama::EmbeddingService).to receive(:call).and_return(fake_embedding)

      expect(condition.embedding).to be_nil
      described_class.call
      condition.reload
      expect(condition.embedding).to_not be_nil
    end
  end
end
