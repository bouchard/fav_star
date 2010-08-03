class ThumbsUpGenerator < ActiveRecord::Generators::Base

  source_root File.expand_path("../templates", __FILE__)

  def manifest
    record do |m|
      m.directory File.join('db', 'migrate')
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => 'thumbs_up'
    end
  end
end
