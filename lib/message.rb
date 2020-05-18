require 'pry'

class Message
  attr_accessor :comment, :author, :board_id
  attr_reader :timestamp, :id
  @@messages = {}
  @@total_rows = 0
  
  def initialize(attributes)
    @comment = attributes.fetch(:comment)
    @author = attributes.fetch(:author)
    @board_id = attributes.fetch(:board_id)
    @id = attributes.fetch(:id) || @@total_rows += 1
    @timestamp = Time.new()
  end

  def self.all
    @@messages.values()
    # binding.pry
  end

  def ==(comment_to_compare)
    (self.comment() == comment_to_compare.comment()) && (self.board_id() == comment_to_compare.board_id())
  end

  def save 
    @@messages[self.id] = Message.new({:comment => self.comment, :author => self.author, :board_id => self.board_id, :id => self.id})
  end

  def self.clear
    @@messages = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@messages[id]
  end

  def update(comment, board_id)
    self.comment = comment
    self.board_id = board_id
    @@messages[self.id] = Message.new({:comment => self.comment, :author => self.author, :board_id => self.board_id, :id => self.id})
  end

  def delete()
    @@messages.delete(self.id)
  end

  def self.sort
    Message.all.sort_by{|time| time.timestamp}
  end

  def self.find_by_board(board_id)
    messages = []
    @@messages.values.each do |comment|
      if comment.board_id == board_id
        messages.push(comment)
      end
    end
    messages
  end

  def board
    Board.find(self.board_id)
  end
end