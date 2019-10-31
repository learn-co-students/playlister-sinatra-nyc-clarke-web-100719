require 'rack-flash'

class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash

    get '/songs' do
        @songs = Song.all 
        erb :'songs/index'
    end
      
      
    get '/songs/new' do
        @genres = Genre.all #to display genres in dropdown menu
        erb :'songs/new'
    end

    get '/songs/:slug' do        
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    post '/songs' do
        name = params[:name]
        artist_name = params[:artist]
        artist = Artist.find_or_create_by(name: artist_name)
        @song = Song.find_or_create_by(name: name, artist_id: artist.id) #create new songs

        genre_ids = params[:genres]
        genre_ids.each do |genre_id|
            SongGenre.create(genre_id: genre_id, song_id: @song.id)
        end
        
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}" #redirect back to songs index page
    end

    get '/songs/:slug/edit' do
        @genres = Genre.all
        @song = Song.find_by_slug(params[:slug])        
        @genre_ids = @song.genres.map { |genre| genre.id }
        erb :"songs/edit"
    end

      patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        if params[:name] == ""
            name = @song.name
        else
            name = params[:name]
        end

        if params[:artist] == ""
            artist_name = @song.artist.name
        else
            artist_name = params[:artist]
        end
        artist = Artist.find_or_create_by(name: artist_name)

        @song.song_genres.each { |song_genre| song_genre.destroy }
        genre_ids = params[:genres]
        genre_ids.each do |genre_id|
            SongGenre.create(genre_id: genre_id, song_id: @song.id)
        end
        @song.update(name: name, artist_id: artist.id)

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"               
      end    
end
