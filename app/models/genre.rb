class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    
    include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods

    def artists
        self.songs.map { |song| song.artist }.uniq
    end
end