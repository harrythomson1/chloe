require 'rails_helper'
RSpec.describe Nhs::ConditionSymptomsSyncService do
  describe '.call' do
    let!(:condition) { create(:condition) }
    it 'makes a request to the NHS API' do
      stub_request(:get, condition.source_url)
        .to_return(
          status: 200,
          body: { 'hasPart' => [] }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      described_class.call

      expect(a_request(:get, condition.source_url)).to have_been_made
    end
  end
end
