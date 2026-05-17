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

    it 'iterates through all conditions in the database' do
      condition2 = create(:condition, name: 'Asthma', source_url: 'https://api.service.nhs.uk/nhs-website-content/conditions/asthma/')
      stub_request(:get, condition.source_url)
        .to_return(
          status: 200,
          body: { 'hasPart' => [] }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      stub_request(:get, condition2.source_url)
        .to_return(
          status: 200,
          body: { 'hasPart' => [] }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      described_class.call

      expect(a_request(:get, condition.source_url)).to have_been_made
      expect(a_request(:get, condition2.source_url)).to have_been_made
    end
  end
end
