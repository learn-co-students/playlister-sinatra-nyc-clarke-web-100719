require 'rack-flash'

class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash

    get '/songs' do

        @songs = Song.all #define instance variable for view
      
        erb :'songs/index' #show all songs view (index)
      
    end
      
      
    get '/songs/new' do
        @genres = Genre.all

        erb :'songs/new' #show new songs view
    
    end


    post '/songs' do

        #below works with properly formatted params in HTML form
        name = params[:name]
        artist_name = params[:artist]
        artist = Artist.find_or_create_by(name: artist_name)
        @song = Song.find_or_create_by(name: name, artist_id: artist.id) #create new songs

        genre_ids = params[:genres]
        genre_ids.each do |genre_id|
            SongGenre.create(genre_id: genre_id, song_id: @song.id)
        end
        
        if @song #saves new songs or returns false if unsuccessful
            flash[:message] = "Successfully created song."
            redirect "/songs/#{@song.slug}" #redirect back to songs index page
        else
            erb :'songs/new' # show new songs view again(potentially displaying errors)
        end
    
    end

    get '/songs/:slug' do

        #gets params from url
        
        @song = Song.find_by_slug(params[:slug]) #define instance variable for view
        

        erb :'songs/show' #show single songs view
        
    end

    get '/songs/:slug/edit' do
        @genres = Genre.all
        #get params from url

        @song = Song.find_by_slug(params[:slug]) #define intstance variable for view
        
        @genre_ids = @song.genres.map { |genre| genre.id }

        erb :"songs/edit" #show edit songs view
        
    end

      patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug]) #define variable to edit
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

        #get params from url
        @song.song_genres.each { |song_genre| song_genre.destroy }
        genre_ids = params[:genres]
        genre_ids.each do |genre_id|
            SongGenre.create(genre_id: genre_id, song_id: @song.id)
        end
        @song.update(name: name, artist_id: artist.id)

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}" 
              
      end

      delete '/songs/:slug' do

        #get params from url
        @song = Song.find(params[:slug]) #define songs to delete
      
        @song.destroy #delete songs
      
        redirect '/songs' #redirect back to songs index page
      
      end
    
    
end
