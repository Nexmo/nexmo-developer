require 'rails_helper'
require 'common_errors'

RSpec.describe CommonErrors do
  describe '#check_for_migration_error' do
    let(:migrate_error) { 'Error! Migrations are pending. Please run rake db:migrate' }
    let(:expected_error) { 'DB Migration is pending. Please run RAILS_ENV=development bin/rake db:migrate' }

    it 'does not raise if migrations are not pending' do
      expect { described_class.check_for_migration_error('Everything is fine! No need to worry') }.not_to raise_error
    end

    it 'raises an error if request body includes a migration request' do
      expect { described_class.check_for_migration_error(migrate_error) }.to raise_error(expected_error)
    end

    it 'is not case sensitive' do
      expect { described_class.check_for_migration_error(migrate_error.upcase) }.to raise_error(expected_error)
    end
  end
end
