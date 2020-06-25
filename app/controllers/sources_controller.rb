class SourcesController < AppController
    # create routes ###############################
    # get '/sources/new' do
    #   erb :"/landmarks/new"
    # end
  
    # post '/sources' do    
    #   landmark = Landmark.create(name: params[:landmark_name], year_completed: params[:landmark_year_completed])    
    #   redirect "/landmarks/#{landmark.id}"
    # end
  
    # read routes #################################
    # get '/sources' do
    #   @sources = Source.all
    #   erb :"/sources/index"
    # end
  
    get '/sources/:id' do
        @source = Source.find(params[:id])
        erb :"/sources/show"
    end
  
    # update routes ###############################
    get '/sources/:id/edit' do
        @source = Source.find(params[:id])
        @topics = Topic.all        
        erb :"/sources/edit"
    end
  
    patch '/sources/:id' do
        source = Source.find(params[:id])
        source.update(params[:source])
        redirect "/sources/#{source.id}"
    end
  
  
    # delete routes ###############################
  end