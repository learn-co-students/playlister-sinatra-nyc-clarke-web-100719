class SongsController < ApplicationController
    get '/songs' do
        @songs = Song.all
        erb :"songs/index"
    end

    get '/songs/new' do

        erb :"songs/new"
    end

    post '/songs' do
        @artist = Artist.find_or_create_by(name: params[:artist])
        @song = Song.create(name: params[:name], artist: @artist)
        redirect to ("/songs/#{@song.slug}")
    end

    get '/songs/:slug' do
        # if Song.find_by_slug(params[:slug])
            @song = Song.find_by_slug(params[:slug])

            erb :"songs/show"
        # else
        #     binding.pry
        # redirect to "/songs/#{params[:slug].to_i}"
        # end
    end
    
    # get '/songs/:id' do
    #     @song = Song.find(params[:id])
    #     erb :"songs/show"
    # end

end