require 'bundler/setup'
require 'erb'
require 'dotenv'
require 'active_record'

include ActiveRecord::Tasks

root = File.expand_path('../config', 'database.yml')
DatabaseTasks.root = root
DatabaseTasks.db_dir = File.join(root, 'db')
DatabaseTasks.migrations_paths = [File.join(root, 'db/migrate')]
DatabaseTasks.env = ENV['ENV'] || 'development'
Dotenv.load('../config', 'personal_data.env')
DatabaseTasks.database_configuration = YAML.load(ERB.new(IO.read(File.join(root, 'database.yml'))).result)
# DatabaseTasks.seed_loader

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection(DatabaseTasks.env.to_sym)
end

load 'active_record/railties/databases.rake'
