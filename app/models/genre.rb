class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artist_genres
    has_many :artists, through: :artist_genres

    def artists
        artist_id = ArtistGenre.all.map {|ag|
            ag.artist_id if ag.genre_id == self.id
    }.compact
        arr = []
        artist_id.each {|id|
            arr << Artist.find(id)
        }
        arr
    end


end