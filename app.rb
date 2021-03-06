require('sinatra')
require('sinatra/reloader')
require('./lib/board')
require('./lib/message')
require('pry')
require('pg')

DB = PG.connect({:dbname => "message_board"})
also_reload('lib/**/*.rb')

get('/') do
  @boards = Board.all
  erb(:homepage)
end

get('/homepage') do
  @boards = Board.all
  erb(:homepage)
end

get('/homepage/giddyup') do
  @boards = Board.all
  erb(:giddyup)
end

post('/homepage/giddyup') do 
  name = params[:board_name]
  topic = params[:board_topic]
  author = params[:board_author]
  board = Board.new({:name => name, :topic => topic, :author => author, :id => nil})
  board.save()
  redirect to('/homepage')
end

get('/homepage/:id') do
  @board = Board.find(params[:id].to_i())
  erb(:view)
end

post('/homepage/:id/comments') do
  @board = Board.find(params[:id].to_i())
  comment = params[:comment]
  author = params[:author]
  message = Message.new({:comment => comment, :author => author, :board_id => @board.id, :id => nil})
  message.save()
  erb(:view)
end

get('/homepage/:id/comments/:message_id') do
  @message = Message.find(params[:message_id].to_i())
  erb(:edit)
end

patch('/homepage/:id/comments/:message_id') do
  @board = Board.find(params[:id].to_i())
  @message = Message.find(params[:message_id].to_i())
  @message.update(params[:comment], @board.id)
  erb(:view)
end

delete('/homepage/:id/comments/:message_id') do 
  @board =  @board = Board.find(params[:id].to_i())
  @message = Message.find(params[:message_id].to_i())
  @message.delete
  erb(:view)
end
