require 'rails_helper'
RSpec.describe Nhs::ConditionSymptomsSyncService do
  describe '.call' do
    let!(:condition) { create(:condition) }
    before do
      stub_request(:get, condition.source_url)
        .to_return(
          status: 200,
          body: Rails.root.join('spec/fixtures/nhs_condition_detail.json').read,
          headers: { 'Content-Type' => 'application/json' }
        )
    end
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

    it 'adds symptoms to the condition' do
      described_class.call
      expect(condition.reload.symptoms).to_not be_nil
    end

    it 'does not update conditions without a symptoms section' do
      described_class.call
      condition2 = create(:condition, name: 'Asthma', source_url: 'https://api.service.nhs.uk/nhs-website-content/conditions/asthma/')
      stub_request(:get, condition2.source_url)
        .to_return(
          status: 200,
          body: { 'hasPart' => [] }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      expect(condition2.reload.symptoms).to be_nil
    end
  end
end
