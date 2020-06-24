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
    #   binding.pry
      erb :"/sources/show"
    end
  
    # update routes ###############################
    # get '/sources/:id/edit' do
    #   @landmark = Landmark.find(params[:id])
    #   erb :"/sources/edit"
    # end
  
    # patch '/sources/:id' do
    #   landmark = Landmark.find(params[:id])    
    #   landmark.update(name: params[:name], year_completed: params[:year_completed])
    #   redirect "/sources/#{landmark.id}"
    # end
  
  
    # delete routes ###############################
  end