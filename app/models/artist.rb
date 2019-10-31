require_relative './concerns/slugifiable'

class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :song_genres
    
    include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods

    def genres
        self.songs.map { |song| song.genres }.flatten.uniq
    end
end