require 'spec_helper'

describe '#Message' do

  before(:each) do
    @board = Board.new({:name => "yee-haw", :topic => "horse tails", :author => "Molly", :id => nil})
    @board.save()
    @comment = Message.new({:comment => "yas! love!", :author => "Molly", :id => nil, :board_id => @board.id})
    @comment.save()
    @comment2 = Message.new({:comment=> "omg! same girl!", :author => "brittany", :id => nil, :board_id => @board.id}) 
    @comment2.save()
  end

  describe('.all') do
    it("returns an empty array if there are no comments") do
      Message.clear()
      expect(Message.all).to(eq([])) 
    end
  end

  describe('#==') do
    it("is the same message if it has the same attributes as another song") do
      expect(@comment2).to(eq(@comment2))
    end
  end

  describe('#save') do
    it("saves a comment") do
      expect(Message.all).to(eq([@comment, @comment2])) 
    end
  end

  describe('.clear') do
    it("clears all comments") do
      Message.clear()
      expect(Message.all).to(eq([]))
    end
  end

  describe('#update') do
    it("updates a comment by id") do
     @comment.update("Neigh", @board.id)
     expect(@comment.comment).to(eq("Neigh"))
    end
  end

  describe('#delete') do 
    it("deletes a comment") do 
     @comment.delete()
     expect(Message.all).to(eq([@comment2]))
    end
  end
end

#   describe('#inititalize') do
#     it ("initializes an object") do
#       expect(@comment.comment).to(eq( "yas! love!"))
#     end
#   end





#   describe('.find') do
#     it("finds a comment by id") do
#       expect(Message.find(@comment.id)).to(eq(@comment))
#     end
#   end


#   describe('#sort') do
#     it("sorts by time time stamp") do
#       comment3 = Message.new({:comment => "her hair is so pretty!", :author => "Jenny", :board_id => @board.id, :id => nil})
#       comment3.save()
#       expect(Message.sort()).to(eq([@comment, @comment2, comment3]))
#     end
#   end  
# end