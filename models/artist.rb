require('pry')
require('pg')
require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(artist_hash)
    @name = artist_hash['name']
    @id = artist_hash['id'].to_i if artist_hash['id']
  end

  def save_artist_to_db()
    sql = "
      INSERT INTO artists
      (name)
      VALUES
      ($1)
      RETURNING id;
    "
    values = [@name]
    result_array = SqlRunner.run(sql, values)
    @id = result_array[0]['id']
  end

  def self.list_all_artists()
    sql = "SELECT * FROM artists;"
    result_array = SqlRunner.run(sql)
    list = result_array.map { |artist| Artist.new(artist) }
    artists_list = list.map { |artist| artist.name }
    return artists_list
  end

  def self.delete_all_artists()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def update_artist()
    sql = "
      UPDATE artists
        SET (name) = ($1)
        WHERE id = $2;
    "
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end



end
