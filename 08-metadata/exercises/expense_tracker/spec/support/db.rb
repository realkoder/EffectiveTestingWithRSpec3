RSpec.configure do |c|
  c.before(:suite) do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
    DB[:expenses].truncate

    FileUtils.mkdir_p('log')
    require 'logger'
    DB.loggers << Logger.new('log/sequel.log')
  end

  c.around(:example, :db) do |example|
    DB.transaction(rollback: :always) { example.run }
  end

  c.before(:example, :db) do |example|
    # File.write("log/sequel.log", "Starting example: #{example.metadata[:description]}\n", mode: "a")
    DB.log_info("Starting example: #{example.metadata[:description]}")
  end

  c.after(:example, :db) do |example|
    DB.log_info("Ending example: #{example.metadata[:description]}\n")
  end
end