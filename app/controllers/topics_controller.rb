class TopicsController < AppController
    # create routes ###############################
    get '/topics/new' do
        @subjects = Subject.all
        erb :"/topics/new"
    end

    post '/topics' do
        if !params[:topic][:subject_id] && params[:subject][:name].empty?            
            redirect "/topics/new"
        else
            topic = Topic.create(params[:topic])
            
            if !params[:subject][:name].empty?
                subject = Subject.create(params[:subject])
                subject.topics << topic
            end

            redirect "/topics/#{topic.id}"
        end
    end
  
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