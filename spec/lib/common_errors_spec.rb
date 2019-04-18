require 'rails_helper'
require 'common_errors'

RSpec.describe CommonErrors do
  describe '#check_for_migration_error' do
    it 'raises an error if request body includes a migration request' do
      session = ActionDispatch::Integration::Session.new(Rails.application)
      allow(session).to receive(:get).and_return(mock_body)

      puts described_class.check_for_migration_error(session)
    end
  end
end

def mock_body
  'Migrations are pending.'
end
