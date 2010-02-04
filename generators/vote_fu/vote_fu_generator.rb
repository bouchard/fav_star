class VoteFuGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => 'vote_fu_migration'
      m.directory File.join('app', 'models')
      m.template 'vote.rb', File.join('app', 'models', 'vote.rb')
    end
  end
end
