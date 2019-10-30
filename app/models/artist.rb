class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs

    def slug
        Slug.convert(self.name)
    end

    def self.find_by_slug(sl)
        Artist.all.find {|artist| artist.slug == sl}
    end
end