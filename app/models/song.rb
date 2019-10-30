class Song < ActiveRecord::Base
    has_many :song_genres
    has_many :genres, through: :song_genres
    belongs_to :artist

    def slug
        Slug.convert(self.name)
    end

    def self.find_by_slug(sl)
        Song.all.find {|song| song.slug == sl}
    end
end