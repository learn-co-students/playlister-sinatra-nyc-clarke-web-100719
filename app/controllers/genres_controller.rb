class GenresController < ApplicationController
    get '/genres' do

        @genres = Genre.all #define instance variable for view
      
        erb :'genres/index' #show all genres view (index)
      
      end

      get '/genres/:slug' do

        #gets params from url
      
        @genre = Genre.find_by_slug(params[:slug]) #define instance variable for view
      
        erb :'genres/show' #show single artist view
      
      end
end
