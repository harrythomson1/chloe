require 'rails_helper'

RSpec.describe Ollama::ConditionsEmbeddingService do
  it 'makes a call to the embedding service' do
    allow(Ollama::EmbeddingService).to receive(:call)
    described_class.call
    expect(Ollama::EmbeddingService).to have_received(:call)
  end
end
