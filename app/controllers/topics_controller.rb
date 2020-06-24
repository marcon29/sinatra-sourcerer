class TopicsController < AppController
    # create routes ###############################

  
    # read routes #################################    
    # also serves as sources index
    get '/topics/:id' do
        @topic = Topic.find(params[:id])
        @sources = Source.all
        erb :"/topics/show"
    end
    
    # update routes ###############################

        
    # delete routes ###############################


end