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

        redirect "/topics/#{topic.slug}"
    end
  
    # read routes #################################    
    # also serves as sources index
    get '/topics/:slug' do        
        @topic = Topic.find_by_slug(params[:slug])
        erb :"/topics/show"
    end
    
    # update routes ###############################
    get '/topics/:slug/edit' do
        @topic = Topic.find_by_slug(params[:slug])
        @subjects = Subject.all        
        erb :"/topics/edit"
    end
  
    patch '/topics/:slug' do
        topic = Topic.find_by_slug(params[:slug])
        topic.update(params[:topic])

        if new_subject?
            subject = Subject.create(params[:subject])
            subject.topics << topic
        end

        redirect "/topics/#{topic.slug}"
    end
        
    # delete routes ###############################
    delete '/topics/:slug' do
        # source = Source.find_by_slug(params[:slug])
        # source.destroy        
        redirect "/subjects"        
    end



end