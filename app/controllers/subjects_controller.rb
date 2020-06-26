class SubjectsController < AppController
    # create routes ###############################
    get '/subjects/new' do        
        erb :"/subjects/new"
    end

    post '/subjects' do
        subject = Subject.create(params[:subject])

        if new_topic?
            topic = Topic.create(params[:topic])
            topic.subject = subject
            topic.save
        end
        
        redirect "/subjects"
    end
  
    # read routes #################################
    # also serves as topics index
    get '/subjects' do
        @subjects = Subject.all
        erb :"/subjects/index"
    end    
    
    # update routes ###############################
    get '/subjects/:slug/edit' do
        @subject = Subject.find_by_slug(params[:slug])
        @topics = Topic.all        
        erb :"/subjects/edit"
    end
  
    patch '/subjects/:slug' do
        subject = Subject.find_by_slug(params[:slug])
        subject.update(params[:subject])

        if new_topic?
            topic = Topic.create(params[:topic])
            topic.subject = subject
            topic.save
        end

        redirect "/subjects"
    end
        
    # delete routes ###############################
    delete '/subjects/:slug' do
        # source = Source.find_by_slug(params[:slug])
        # source.destroy
        redirect "/subjects"
    end


    

end