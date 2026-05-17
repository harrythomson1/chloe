require 'rails_helper'
RSpec.describe Nhs::ConditionSymptomsSyncJob do
  it 'calls the sync service' do
    allow(Nhs::ConditionSymptomsSyncService).to receive(:call)
    described_class.perform_now
    expect(Nhs::ConditionSymptomsSyncService).to have_received(:call)
  end
end
