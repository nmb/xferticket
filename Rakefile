require 'sequel'
require 'sinatra'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    Sequel.extension :migration
    db = Sequel.sqlite((ENV["DATABASE_URL"] || "#{File.expand_path(File.dirname(__FILE__))}/#{Sinatra::Base.environment}.db"))
    migration_path = "db/migrations"

    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, migration_path, target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, migration_path)
    end
  end
end

