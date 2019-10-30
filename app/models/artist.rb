class Artist < ActiveRecord::Base
    has_many :artist_genres
    has_many :songs
    has_many :genres, through: :artist_genres

    def genres
        genre_id = ArtistGenre.all.map {|ag|
            ag.genre_id if ag.artist_id == self.id
    }.compact
        arr = []
        genre_id.each {|id|
            arr << Genre.find(id)
        }
        arr
    end


end