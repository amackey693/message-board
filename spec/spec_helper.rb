require 'rspec'
require 'message'
require 'board'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => "message_board_test"})
RSpec.configure do |config| 
  config.after(:each) do
    DB.exec("DELETE FROM boards *;")
    DB.exec("DELETE FROM messages *;")
  end
end
