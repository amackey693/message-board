require 'pry'

class Board
  attr_accessor :name, :topic, :author
  attr_reader :timestamp, :id
  @@boards = {}
  @@total_rows = 0
  
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @topic = attributes.fetch(:topic)
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id) || @@total_rows += 1
    @timestamp = Time.new()
  end

  def self.all
    @@boards.values()
    # binding.pry
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
end