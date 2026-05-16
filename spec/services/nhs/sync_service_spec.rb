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
  end
end
