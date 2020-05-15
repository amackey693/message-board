require('sinatra')
require('sinatra/reloader')
require('./lib/board')
require('./lib/message')
require('pry')
also_reload('lib/**/*.rb')


# EXAMPLES FOR GET, POST, PATCH & DELETE

get('/') do
  @boards = Board.all
  erb(:homepage)
end

get('/homepage') do
  @boards = Board.all
  erb(:homepage)
end

get('/homepage/giddyup') do
  erb(:giddyup)
end

get('/homepage/:id/view') do
  @board = Board.find(params[:id].to_i())
  erb(:view)
end

post('/homepage/giddyup') do 
  name = params[:board_name]
  topic = params[:board_topic]
  author = params[:board_author]
  board = Board.new({:name => name, :topic => topic, :author => author, :id => nil})
  board.save()
  redirect to('/homepage')
end

post('/hompage/:id/comments') do
  comment = params[:comment]
  author = params[:author]
  @board = Board.find(params[:id].to_i())
  message = Message.new({:comment => comment, :author => author, :board_id => @board.id, :id => nil})
  message.save()
  redirect to('/homepage/:id/view')
end

# post('/albums/:id/songs') do
#   @album = Album.find(params[:id].to_i())
#   song = Song.new(params[:song_name], @album.id, nil)
#   song.save()
#   erb(:album)
# end

# get('/albums/new') do
#   erb(:new_album)
# end

# post('/albums') do ## Adds album to list of albums, cannot access in URL bar
#   name = params[:album_name]
#   artist = params[:album_artist]
#   year = params[:album_year]
#   genre = params[:album_genre]
#   song = params[:song_id]
#   in_inventory = params[:in_inventory]
#   album = Album.new(name, nil, artist, genre, year)
#   album.save()
#   redirect to('/albums')
# end

# patch('/albums/:id') do
#   @album = Album.find(params[:id].to_i())
#   @albums = Album.all
#   if params[:buy]
#     @album.sold()
#   else  
#     @album.update(params[:name])
#   end
#   erb(:albums)
# end

# delete('/albums/:id') do
#   @album = Album.find(params[:id].to_i())
#   @album.delete()
#   redirect to('/albums')
# end