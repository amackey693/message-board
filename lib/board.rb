require 'pry'

class Board

  attr_accessor :name, :topic, :author
  attr_reader :timestamp
  @@boards = {}
  
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @topic = attributes.fetch(:topic)
    @author = attributes.fetch(:author)
    @timestamp = Time.new()
  end
end
