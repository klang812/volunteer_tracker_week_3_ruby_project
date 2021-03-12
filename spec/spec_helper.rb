require 'rspec'
require 'pg'
require 'project'
require 'volunteer'
require 'pry'

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM volunteers *;")
    DB.exec("DELETE FROM projects *;")
    # DB.exec("INSERT INTO projects (title) VALUES ('Teaching Kids to Code');")
  end
end