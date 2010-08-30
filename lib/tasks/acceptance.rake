##
# Adapted from <RAILS_GEM>/lib/tasks/databases.rake
##
namespace :db do
  namespace :acceptance do
    desc "Recreate the acceptance database from the current schema.rb"
    task :load => 'db:acceptance:purge' do
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['acceptance'])
      ActiveRecord::Schema.verbose = false
      Rake::Task["db:schema:load"].invoke
    end

    desc "Recreate the acceptance database from the current environment's database schema"
    task :clone => %w(db:schema:dump db:acceptance:load)

    desc "Recreate the acceptance databases from the development structure"
    task :clone_structure => [ "db:structure:dump", "db:acceptance:purge" ] do
      abcs = ActiveRecord::Base.configurations
      case abcs["acceptance"]["adapter"]
      when "mysql"
        ActiveRecord::Base.establish_connection(:acceptance)
        ActiveRecord::Base.connection.execute('SET foreign_key_checks = 0')
        IO.readlines("#{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql").join.split("\n\n").each do |table|
          ActiveRecord::Base.connection.execute(table)
        end
      when "postgresql"
        ENV['PGHOST']     = abcs["acceptance"]["host"] if abcs["acceptance"]["host"]
        ENV['PGPORT']     = abcs["acceptance"]["port"].to_s if abcs["acceptance"]["port"]
        ENV['PGPASSWORD'] = abcs["acceptance"]["password"].to_s if abcs["acceptance"]["password"]
        `psql -U "#{abcs["acceptance"]["username"]}" -f #{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql #{abcs["acceptance"]["database"]}`
      when "sqlite", "sqlite3"
        dbfile = abcs["acceptance"]["database"] || abcs["acceptance"]["dbfile"]
        `#{abcs["acceptance"]["adapter"]} #{dbfile} < #{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql`
      when "sqlserver"
        `osql -E -S #{abcs["acceptance"]["host"]} -d #{abcs["acceptance"]["database"]} -i db\\#{RAILS_ENV}_structure.sql`
      when "oci", "oracle"
        ActiveRecord::Base.establish_connection(:acceptance)
        IO.readlines("#{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql").join.split(";\n\n").each do |ddl|
          ActiveRecord::Base.connection.execute(ddl)
        end
      when "firebird"
        set_firebird_env(abcs["acceptance"])
        db_string = firebird_db_string(abcs["acceptance"])
        sh "isql -i #{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql #{db_string}"
      else
        raise "Task not supported by '#{abcs["acceptance"]["adapter"]}'"
      end
    end

    desc "Empty the acceptance database"
    task :purge => :environment do
      abcs = ActiveRecord::Base.configurations
      case abcs["acceptance"]["adapter"]
      when "mysql"
        ActiveRecord::Base.establish_connection(:acceptance)
        ActiveRecord::Base.connection.recreate_database(abcs["acceptance"]["database"], abcs["acceptance"])
      when "postgresql"
        ActiveRecord::Base.clear_active_connections!
        drop_database(abcs['acceptance'])
        create_database(abcs['acceptance'])
      when "sqlite","sqlite3"
        dbfile = abcs["acceptance"]["database"] || abcs["acceptance"]["dbfile"]
        File.delete(dbfile) if File.exist?(dbfile)
      when "sqlserver"
        dropfkscript = "#{abcs["acceptance"]["host"]}.#{abcs["acceptance"]["database"]}.DP1".gsub(/\\/,'-')
        `osql -E -S #{abcs["acceptance"]["host"]} -d #{abcs["acceptance"]["database"]} -i db\\#{dropfkscript}`
        `osql -E -S #{abcs["acceptance"]["host"]} -d #{abcs["acceptance"]["database"]} -i db\\#{RAILS_ENV}_structure.sql`
      when "oci", "oracle"
        ActiveRecord::Base.establish_connection(:acceptance)
        ActiveRecord::Base.connection.structure_drop.split(";\n\n").each do |ddl|
          ActiveRecord::Base.connection.execute(ddl)
        end
      when "firebird"
        ActiveRecord::Base.establish_connection(:acceptance)
        ActiveRecord::Base.connection.recreate_database!
      else
        raise "Task not supported by '#{abcs["acceptance"]["adapter"]}'"
      end
    end

    desc 'Seeds the acceptance db with the site templates'
    task :seed => :environment do
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['acceptance'])
      event_type = Factory(:basic_event_type, :name => 'Conference', :default_modules => %w(agenda speakers about).to_yaml)
      site_template = Factory(:site_template, :event_type => event_type)
      site_template.set_structure
    end

    desc 'Check for pending migrations and load the acceptance schema'
    task :prepare => 'db:abort_if_pending_migrations' do
      if defined?(ActiveRecord) && !ActiveRecord::Base.configurations.blank?
        Rake::Task[{ :sql  => "db:acceptance:clone_structure", :ruby => "db:acceptance:load" }[ActiveRecord::Base.schema_format]].invoke
      end
    end
  end
end
