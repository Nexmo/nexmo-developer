class CommonErrors
  def self.check_for_migration_error(body)
    raise 'DB Migration is pending. Please run RAILS_ENV=development bin/rake db:migrate' if body.downcase.include?('migrations are pending')
  end
end
