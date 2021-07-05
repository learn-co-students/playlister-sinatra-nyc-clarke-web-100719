class SongsController < ApplicationController

    get '/' do
        @songs = Song.all.map {|song| song.name}
        @slugs = []
        @songs.each {|song_name| @slugs << slug(song_name)}
        erb :songs
    end

    get '/new' do
    
    end

    get '/:slug' do
        song = find_by_slug(params[:slug])
        @genres = song.genres
        @artist = song.artist
        @name = song.name
        erb :song_show
    end

    def find_by_slug(slug)
        Song.find_by(name: super(slug))
    end

end