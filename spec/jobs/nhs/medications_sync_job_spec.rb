require 'rails_helper'
RSpec.describe Nhs::MedicationsSyncJob do
  it 'calls the sync service' do
    allow(Nhs::SyncService).to receive(:call)
    described_class.perform_now
    expect(Nhs::SyncService).to have_received(:call)
  end
end
