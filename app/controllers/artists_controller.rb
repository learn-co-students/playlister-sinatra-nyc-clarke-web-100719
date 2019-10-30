class ArtistsController < ApplicationController
    get '/artists' do

        @artists = Artist.all #define instance variable for view
        
        erb :'artists/index' #show all artists view (index)
    
    end

    get '/artists/:slug' do

        #gets params from url
        
        @artist = Artist.find_by_slug(params[:slug]) #define instance variable for view
        
        erb :'artists/show' #show single artist view
    
    end
end
