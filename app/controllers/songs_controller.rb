require 'rack-flash'
class SongsController < ApplicationController
    
    enable :sessions
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :"songs/index"
    end

    get '/songs/new' do

        erb :"songs/new"
    end

    post '/songs' do
        @artist = Artist.find_or_create_by(name: params[:artist])
        @song = Song.create(name: params[:name], artist_id: @artist.id)
        @song.genre_ids = params[:genre_ids]
        @song.save

        flash[:message] = "Successfully created song."

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

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/edit"
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.name = params[:name]
        @song.genre_ids = params[:genre_ids]
        @artist = Artist.find_or_create_by(name: params[:artist])
        @song.artist = @artist
        @song.save
        flash[:message] = "Successfully updated song."
        redirect "songs/#{@song.slug}"
    end
    
    # get '/songs/:id' do
    #     @song = Song.find(params[:id])
    #     erb :"songs/show"
    # end

end