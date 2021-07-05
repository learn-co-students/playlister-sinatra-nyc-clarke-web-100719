class ArtistsController < ApplicationController

    get '/' do
        @artists = Artist.all.map {|artist| artist.name}
        @slugs = []
        @artists.each {|artist_name| @slugs << slug(artist_name)}
        erb :artists
    end

    get '/:slug' do
        artist = find_by_slug(params[:slug])
        @genres = artist.genres
        @songs = artist.songs
        @name = artist.name
        erb :artist_show
    end

    def find_by_slug(slug)
        Artist.find_by(name: super(slug))
    end

end
