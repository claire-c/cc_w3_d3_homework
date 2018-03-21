require('pry')
require('pg')
require_relative('models/album.rb')
require_relative('models/artist.rb')
require_relative('db/sql_runner.rb')

artist_hash1 = { 'name' => 'Michael Jackson'}
artist_hash2 = { 'name' => 'Neil Young'}
artist_hash3 = { 'name' => 'PJ Harvey'}

michael = Artist.new(artist_hash1)
michael.save_artist_to_db()

# neil = Artist.new(artist_hash2)
# neil.save_artist_to_db()
#
# pj = Artist.new(artist_hash3)
# pj.save_artist_to_db()

album_hash1 = { 'title' => 'Off The Wall', 'genre' => 'disco', 'artist_id' => michael.id }


off_the_wall = Album.new(album_hash1)

off_the_wall.save_album_to_db()

album_hash2 = { 'title' => 'Thriller', 'genre' => 'pop', 'artist_id' => michael.id}
thriller = Album.new(album_hash2)
thriller.save_album_to_db()

# album_hash3 = { 'title' => 'Harvest Moon', 'genre' => 'folk', 'artist_id' => neil.id}
# harvest_moon = Album.new(album_hash3)
# harvest_moon.save_album_to_db()
#
# album_hash4 = { 'title' => 'Dry', 'genre' => 'rock', 'artist_id' => pj.id}
# dry = Album.new(album_hash4)
# dry.save_album_to_db()
#p Album.list_all_albums()
#p Artist.list_all_artists()

#p Album.list_albums_by_artist(michael)

#p thriller.get_artist_id()
p thriller.get_artist_name()

# Show an album's artist
