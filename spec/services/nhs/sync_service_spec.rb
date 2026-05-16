require 'rails_helper'
RSpec.describe Nhs::SyncService do
  describe '.call' do
    it 'makes a request to the NHS API' do
      url = 'https://api.service.nhs.uk/nhs-website-content/conditions/'
      stub_request(:get, url)
        .to_return(
          status: 200,
          body: { 'significantLink' => [], 'relatedLink' => [] }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      described_class.call(url: url, model: Condition)

      url = 'https://api.service.nhs.uk/nhs-website-content/conditions/'
      expect(a_request(:get, url)).to have_been_made
    end

    it 'adds published conditions to the database' do
      url = 'https://api.service.nhs.uk/nhs-website-content/conditions/'
      stub_request(:get, url)
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
      described_class.call(url: url, model: Condition)
      expect(Condition.count).to eq(2)
    end

    it 'confirm that the adding conditions is idempotent' do
      url = 'https://api.service.nhs.uk/nhs-website-content/conditions/'
      stub_request(:get, url)
        .to_return(
          status: 200,
          body: Rails.root.join('spec/fixtures/nhs_conditions_response_page_1.json').read,
          headers: { 'Content-Type' => 'application/json' }
        )
      stub_request(:get, "#{url}?page=2")
        .to_return(
          status: 200,
          body: Rails.root.join('spec/fixtures/nhs_conditions_response_page_2.json').read,
          headers: { 'Content-Type' => 'application/json' }
        )
      described_class.call(url: url, model: Condition)
      described_class.call(url: url, model: Condition)
      expect(Condition.count).to eq(2)
    end
  end
end
