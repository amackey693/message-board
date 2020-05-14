require 'rspec'
require 'message'
require 'board'
require 'pry'

 
describe '#Board' do
  describe('#inititalize') do
    it ("initializes an object") do
      board = Board.new(({:name => "yee-haw", :topic => "horse-tails", :author => "Molly"}) )
      expect(board.name).to(eq("yee-haw"))
    end
  end
end