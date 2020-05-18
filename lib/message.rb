require 'pry'

class Message
  attr_accessor :comment, :author, :board_id
  attr_reader :timestamp, :id
  
  def initialize(attributes)
    @comment = attributes.fetch(:comment)
    @author = attributes.fetch(:author)
    @board_id = attributes.fetch(:board_id)
    @id = attributes.fetch(:id)
    @timestamp = Time.new()
  end

  def self.all
    returned_messages = DB.exec("SELECT * FROM messages;")
    messages = []
    returned_messages.each() do |message|
      comment = message.fetch("comment")
      author = message.fetch("author")
      board_id = message.fetch("board_id").to_i()
      id = message.fetch("id").to_i()
      messages.push( Message.new({:comment => comment, :author => author, :id => id, :board_id => board_id}) )
    end
    messages
  end

  def ==(comment_to_compare)
    (self.comment() == comment_to_compare.comment()) && (self.board_id() == comment_to_compare.board_id())
  end

  def save
    message = DB.exec("INSERT INTO messages (comment, author, board_id) VALUES ('#{@comment}', '#{@author}', #{@board_id}) RETURNING id;")
    @id = message.first().fetch("id").to_i
  end

  def self.clear
    DB.exec("DELETE FROM messages *;")
  end

  def self.find(id)
    @@messages[id]
  end

  def update(comment, board_id)
    @comment = comment
    @board_id = board_id 
    DB.exec("UPDATE messages SET comment = '#{@comment}', board_id = #{@board_id} WHERE id = #{@id};")
  end

  def delete()
   DB.exec("DELETE FROM messages WHERE id = #{@id};")
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