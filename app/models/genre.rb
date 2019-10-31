class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def slug
        Slug.convert(self.name)
    end

    def self.find_by_slug(sl)
        Genre.all.find {|genre| genre.slug == sl}
    end
end