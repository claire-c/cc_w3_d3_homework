require('pry')
require('pg')

class Album

  attr_reader :id, :title, :genre, :artist_id

  def initialize(album_hash)
    @title = album_hash['title']
    @genre = album_hash['genre']
    @artist_id = album_hash['artist_id'].to_i
    @id = album_hash['id'].to_i if artist_hash['id']
  end





end
