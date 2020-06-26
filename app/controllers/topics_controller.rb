class TopicsController < AppController
    # create routes ###############################
    get '/topics/new' do
        @subjects = Subject.all
        erb :"/topics/new"
    end

    post '/topics' do        
        redirect "/topics/new" if no_subject_assigned?
        
        topic = Topic.create(params[:topic])       

        if new_subject?
            subject = Subject.create(params[:subject])
            subject.topics << topic
        end

        redirect "/topics/#{topic.id}"
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