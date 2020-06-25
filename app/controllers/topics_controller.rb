class TopicsController < AppController
    # create routes ###############################

  
    # read routes #################################    
    # also serves as sources index
    get '/topics/:id' do        
        @topic = Topic.find(params[:id])
        erb :"/topics/show"
    end
    
    # update routes ###############################
    get '/topics/:id/edit' do
        @topic = Topic.find(params[:id])
        @subjects = Subject.all        
        erb :"/topics/edit"
    end
  
    patch '/topics/:id' do
        topic = Topic.find(params[:id])        
        topic.update(params[:topic])
        redirect "/topics/#{topic.id}"
    end
        
    # delete routes ###############################


end