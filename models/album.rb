require('pry')
require('pg')
require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id, :title, :genre, :artist_id

  def initialize(album_hash)
    @title = album_hash['title']
    @genre = album_hash['genre']
    @artist_id = album_hash['artist_id'].to_i
    @id = album_hash['id'].to_i if album_hash['id']
  end

  def save_album_to_db()
    sql = "
      INSERT INTO albums
      (title, genre, artist_id)
      VALUES
      ($1, $2, $3)
      RETURNING id;
    "
    values = [@title, @genre, @artist_id]
    result_array = SqlRunner.run(sql, values)
    @id = result_array[0]["id"]
  end

  def self.list_all_albums
    sql = "SELECT * FROM albums;"
    result_array = SqlRunner.run(sql)
    albums_objs = result_array.map { |album| Album.new(album) }
    albums_list = albums_objs.map { |album| album.title }
    return albums_list
  end

  def self.list_albums_by_artist(artist)
    sql = "
      SELECT * FROM albums
      WHERE artist_id = $1;
    "
    values = [artist] #or artist.id?
    result_array = SqlRunner.run(sql, values)
    albums_list = result_array.map { |album| Album.new(album) }
    album_titles = albums_list.map { |album| album.title }
  end
#artist is the artist object passed in from the runner file. I need to pass in the ID as the value to SQL.


end
