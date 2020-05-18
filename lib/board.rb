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
      id = board.fetch("id")
      boards.push( Board.new({:name => name, :topic => topic, :author => author, :id => id}) )
    end
    boards
  end

  def save 
    @@boards[self.id] = Board.new({:name => self.name, :topic => self.topic, :author => self.author, :id => self.id})
  end

  def ==(board_to_compare)
    self.name() == board_to_compare.name()
  end

  def self.clear
    @@boards = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@boards[id]
  end

  def update(name)
    self.name = name
    @@boards[self.id] = Board.new({:name => self.name, :topic => self.topic, :author => self.author, :id => self.id})
  end

  def delete()
    @@boards.delete(self.id)
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