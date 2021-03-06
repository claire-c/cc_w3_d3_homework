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
        WHERE id = ($2);
    "
    values = [@name, @id]
    binding.pry
    SqlRunner.run(sql, values)
  end
#running an error I can't understand at all!


# /Users/cconnachan/codeclan/e20/workfiles/week_03/day_3/music_library_lab_hw/db/sql_runner.rb:7:in `prepare': ERROR:  source for a multiple-column UPDATE item must be a sub-SELECT or ROW() expression (PG::FeatureNotSupported)
# LINE 3:         SET (name) = ($1)
#                               ^
# 	from /Users/cconnachan/codeclan/e20/workfiles/week_03/day_3/music_library_lab_hw/db/sql_runner.rb:7:in `run'
# 	from /Users/cconnachan/codeclan/e20/workfiles/week_03/day_3/music_library_lab_hw/models/artist.rb:48:in `update_artist'




  def self.find_artist(id)
    string_id = id.to_s
    sql = "
    SELECT * FROM artists
      WHERE id = $1;"

    values = [string_id]
    result_array = SqlRunner.run(sql, values)
    artist_objs = result_array.map { |artist| Artist.new(artist) }
    return artist_objs[0].name
  end

# Find Artists/Albums by their ID



end
