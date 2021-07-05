class GenresController < ApplicationController
    get '/' do
        @genres = Genre.all.map {|genre| genre.name}
        @slugs = []
        @genres.each {|genre_name| @slugs << slug(genre_name)}
        erb :genres
    end

    get '/:slug' do
        genre = find_by_slug(params[:slug])
        @artists = genre.artists
        @songs = genre.songs
        @name = genre.name
        erb :genre_show
    end

    def find_by_slug(slug)
        Genre.find_by(name: super(slug))
    end

end