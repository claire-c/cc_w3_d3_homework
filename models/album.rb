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




end
