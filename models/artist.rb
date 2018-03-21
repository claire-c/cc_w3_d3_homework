require('pry')
require('pg')
require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id, :name

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

  




end
