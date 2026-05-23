require 'rails_helper'
RSpec.describe Ollama::ConditionsEmbeddingServiceJob do
  it 'calls the sync service' do
    allow(Ollama::ConditionsEmbeddingService).to receive(:call)
    described_class.perform_now
    expect(Ollama::ConditionsEmbeddingService).to have_received(:call)
  end
end
