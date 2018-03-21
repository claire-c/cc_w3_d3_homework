require('pry')
require('pg')
require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre

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
    values = [artist.id] #or artist.id?
    result_array = SqlRunner.run(sql, values)
    albums_list = result_array.map { |album| Album.new(album) }
    album_titles = albums_list.map { |album| album.title }
  end

  # def get_artist_id()
  #   sql = "SELECT artist_id FROM albums WHERE title = $1 LIMIT 1;"
  #   values = [@title]
  #   result_array = SqlRunner.run(sql, values)
  #   artist_id = result_array.map { |artist| artist }
  #   binding.pry
  #   return artist_id[0]['artist_id']
  # end

  def get_artist_name()
    sql = "
      SELECT * FROM artists
      WHERE id = $1;
    "
    values = [@artist_id]
    result_array = SqlRunner.run(sql, values)
    artist_objs = result_array.map { |artist| Artist.new(artist) }
    return artist_objs[0].name
  end

  def self.delete_all_albums()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def update_album()
    sql = "
      UPDATE albums
        SET (title, genre, artist_id) = ($1, $2, $3)
        WHERE id = ($4);
    "
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.find_album(id)
    string_id = id.to_s
    sql = "
    SELECT * FROM albums
      WHERE id = $1;"

    values = [string_id]
    result_array = SqlRunner.run(sql, values)
    album_objs = result_array.map { |album| Album.new(album) }
    return album_objs[0].title
  end

end
