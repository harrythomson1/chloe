require 'rails_helper'
RSpec.describe Nhs::SyncService do
  describe '.call' do
    it 'makes a request to the NHS API' do
      stub_request(:get, 'https://api.service.nhs.uk/nhs-website-content/conditions/')
        .to_return(
          status: 200,
          body: { 'significantLink' => [], 'relatedLink' => [] }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      Nhs::SyncService.call

      expect(a_request(:get, 'https://api.service.nhs.uk/nhs-website-content/conditions/')).to have_been_made
    end

    it 'adds published conditions to the database' do
      stub_request(:get, 'https://api.service.nhs.uk/nhs-website-content/conditions/')
        .to_return(
          status: 200,
          body: Rails.root.join('spec/fixtures/nhs_conditions_response_page_1.json').read,
          headers: { 'Content-Type' => 'application/json' }
        )
      stub_request(:get, 'https://api.service.nhs.uk/nhs-website-content/conditions/?page=2')
        .to_return(
          status: 200,
          body: Rails.root.join('spec/fixtures/nhs_conditions_response_page_2.json').read,
          headers: { 'Content-Type' => 'application/json' }
        )
      described_class.call
      expect(Condition.count).to eq(2)
    end

    it 'confirm that the adding conditions is idempotent' do
      stub_request(:get, 'https://api.service.nhs.uk/nhs-website-content/conditions/')
        .to_return(
          status: 200,
          body: Rails.root.join('spec/fixtures/nhs_conditions_response_page_1.json').read,
          headers: { 'Content-Type' => 'application/json' }
        )
      stub_request(:get, 'https://api.service.nhs.uk/nhs-website-content/conditions/?page=2')
        .to_return(
          status: 200,
          body: Rails.root.join('spec/fixtures/nhs_conditions_response_page_2.json').read,
          headers: { 'Content-Type' => 'application/json' }
        )
      described_class.call
      described_class.call
      expect(Condition.count).to eq(2)
    end
  end
end
