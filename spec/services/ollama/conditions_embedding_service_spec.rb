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

    it 'adds vectors to multiple conditions' do
      allow(Ollama::EmbeddingService).to receive(:call).and_return(fake_embedding)
      condition2 = create(:condition, name: 'asthma', source_url: 'testurl.com')
      expect(condition.embedding).to be_nil
      expect(condition2.embedding).to be_nil
      described_class.call
      condition.reload
      condition2.reload
      expect(condition.embedding).to_not be_nil
      expect(condition2.embedding).to_not be_nil
    end

    it 'calls the embedding service with the condition details' do
      allow(Ollama::EmbeddingService).to receive(:call).and_return(fake_embedding)
      described_class.call
      expect(Ollama::EmbeddingService).to have_received(:call).with(
        text: including("#{condition.name} #{condition.description} #{condition.symptoms}")
      )
    end

    it 'skips conditions if there are no symptoms and descriptions' do
      allow(Ollama::EmbeddingService).to receive(:call).and_return(fake_embedding)
      condition2 = create(:condition, name: 'asthma', source_url: 'testurl.com', description: nil, symptoms: nil)
      described_class.call
      condition2.reload
      expect(condition2.embedding).to be_nil
    end

    it 'continues embedding if it hits an error' do
      condition2 = create(:condition, name: 'asthma', source_url: 'testurl.com')
      allow(Ollama::EmbeddingService).to receive(:call)
        .with(text: including(condition.name))
        .and_raise(Ollama::Error)

      allow(Ollama::EmbeddingService).to receive(:call)
        .with(text: including(condition2.name))
        .and_return(fake_embedding)

      described_class.call
      condition.reload
      condition2.reload
      expect(condition.embedding).to be_nil
      expect(condition2.embedding).to_not be_nil
    end

    it 'does not run on jobs where the embedding is not nil' do
      new_embedding = Array.new(768) { rand }
      condition.update!(embedding: new_embedding)
      allow(Ollama::EmbeddingService).to receive(:call).and_return(fake_embedding)

      described_class.call
      expect(Ollama::EmbeddingService).not_to have_received(:call).with(text: including(condition.name))
    end
  end
end
