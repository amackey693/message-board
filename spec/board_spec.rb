require 'rspec'
require 'message'
require 'board'
require 'pry'



describe '#Board' do
  # before(:each) do
  #   Board.clear()
  #   @board = Board.new({:name => "yee-haw", :topic => "horse-tails", :author => "Molly", :id => nil})
  #   @board.save()
  # end

  describe('#inititalize') do
    it ("initializes an object") do
      board = Board.new({:name => "yee-haw", :topic => "horse-tails", :author => "Molly", :id => nil})
      expect(board.name).to(eq("yee-haw"))
    end
  end

  describe('#save') do
    it("saves a board") do
    board1 = Board.new({:name => "yee-haw", :topic => "horse-tails", :author => "Molly", :id => nil})
    board1.save() 
    board2 = Board.new({:name => "Horse Tails", :topic => "Horse-camp", :author => "Brittany", :id => nil}) 
    board2.save()
     expect(Board.all).to(eq([board1, board2])) 
    end
  end
end