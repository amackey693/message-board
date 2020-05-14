require 'rspec'
require 'message'
require 'board'
require 'pry'



describe '#Board' do
  before(:each) do
    Board.clear()
    @board = Board.new({:name => "yee-haw", :topic => "horse tails", :author => "Molly", :id => nil})
    @board.save()
    @board2 = Board.new({:name => "Horse Tails", :topic => "Horse-camp", :author => "Brittany", :id => nil}) 
    @board2.save()
  end

  describe('#inititalize') do
    it ("initializes an object") do
      expect(@board.name).to(eq("yee-haw"))
    end
  end

  describe('#save') do
    it("saves a board") do
      expect(Board.all).to(eq([@board, @board2])) 
    end
  end

  describe('.all') do
    it("returns an empty array if there are no boards") do
      Board.clear()
      expect(Board.all).to(eq([])) 
    end
  end

  describe('.clear') do
    it("clears all boards") do
      Board.clear()
      expect(Board.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same board if it has the same attributes as another board") do
      board1 = Board.new({:name => "yee-haw", :topic => "horse-tails", :author => "Molly", :id => nil})
      board2 = Board.new({:name => "yee-haw", :topic => "horse-tails", :author => "Molly", :id => nil})
      expect(board1).to(eq(board2))
    end
  end

  describe('.find') do
    it("finds a board by id") do
      expect(Board.find(@board.id)).to(eq(@board))
    end
  end

  describe('#update') do
    it("updates a board by id") do
     @board.update("Neigh")
     expect(@board.name).to(eq("Neigh"))
    end
  end

  describe('#delete') do 
    it("deletes a board") do 
     @board.delete()
     expect(Board.all).to(eq([@board2]))
    end
  end

  describe('.search') do 
    it("searches through boards by name and returns boards that match") do 
    expect(Board.search("Tails")).to(eq([@board, @board2]))
    end
  end

  describe('#sort') do
    it("sorts by time time stamp") do
      board3 = Board.new({:name => "nay-nays", :topic => "wrangler jeans", :author => "Jenny", :id => nil})
      expect(Board.sort()).to(eq([@board1, @board2, board3]))
    end
  end

end