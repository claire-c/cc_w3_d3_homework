require('pry')
require('pg')

class Artist

  attr_reader :id, :name

  def initialize(artist_hash)
    @name = artist_hash['name']
    @id = artist_hash['id'].to_i if artist_hash['id']
  end





end
