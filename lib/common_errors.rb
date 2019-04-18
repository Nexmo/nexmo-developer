class CommonErrors
  def self.check_for_migration_error(session)
    raise 'DB Migration is pending. Please run rake db:migrate RAILS_ENV=development.' if session.response.body.include?('Migrations are pending.')
  end
end
