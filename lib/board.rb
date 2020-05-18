require 'pry'

class Board
  attr_accessor :name, :topic, :author
  attr_reader :timestamp, :id
  
  def initialize(attributes)
    @name = attributes.fetch(:name).downcase
    @topic = attributes.fetch(:topic).downcase
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id) 
    @timestamp = Time.new()
  end

  def self.all
    returned_boards = DB.exec("SELECT * FROM boards;")
    boards = []
    returned_boards.each() do |board|
      name = board.fetch("name")
      topic = board.fetch("topic")
      author = board.fetch("author")
      id = board.fetch("id").to_i()
      boards.push( Board.new({:name => name, :topic => topic, :author => author, :id => id}) )
    end
    boards
  end

  def save 
    result = DB.exec("INSERT INTO boards (name, topic, author) VALUES ('#{@name}', '#{@topic}', '#{@author}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(board_to_compare)
    self.name() == board_to_compare.name()
  end

  def self.clear
   DB.exec("DELETE FROM boards *;")
  end

  def self.find(id)
    board = DB.exec("SELECT * FROM boards WHERE id = #{id};").first
    name = board.fetch("name")
    topic = board.fetch("topic")
    author = board.fetch("author")
    id = board.fetch("id").to_i
    Board.new({:name => name, :topic => topic, :author => author, :id => id}) 
  end

  def update(name)
    @name = name
    DB.exec("UPDATE boards SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete()
    DB.exec("DELETE FROM boards WHERE id = #{@id};")
  end

  def self.search(search)
    search = search.downcase
    board_names = Board.all.map {|b| b.name }
    result = []
    all_boards = board_names.grep(/#{search}/)
    all_boards.each do |a| 
      display = Board.all.select {|b| b.name.include?(a) || b.topic.include?(a) }
      result.concat(display)
    end
    result
  end

  def self.sort
    Board.all.sort_by{|time| time.timestamp}
  end

  def comments
    Message.find_by_board(self.id)
  end
end