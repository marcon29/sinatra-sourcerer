class TopicsController < AppController
    # create routes ###############################
    get '/topics/new' do
        @subjects = Subject.all
        erb :"/topics/new"
    end

    post '/topics' do
        topic = Topic.new(params[:topic])

        if new_subject?
            subject = Subject.new(params[:subject])
            if subject.valid?
                subject.topics << topic
            else
                redirect "/topics/new"
            end
        end

        if topic.save
            redirect "/topics/#{topic.slug}"
        else
            redirect "/topics/new"
        end
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

        if new_subject?
            subject = Subject.new(params[:subject])
            subject.topics << topic
            redirect "/topics/#{params[:slug]}/edit" if !subject.valid?
        end

        if topic.update(params[:topic])
            redirect "/topics/#{topic.slug}"
        else
            redirect "/topics/#{params[:slug]}/edit"
        end
    end
        
    # delete routes ###############################
    delete '/topics/:slug' do        
        @topic = Topic.find_by_slug(params[:slug])
        @orphans = find_orphans(@topic)
        @topics = Topic.all

        if params[:reassign]
            params[:reassign].each do |key, value|                
                if value[:topic_ids]
                    source = Source.find(value[:id])
                    source.update(topic_ids: value[:topic_ids])
                end
            end
            
            @orphans = find_orphans(@topic)
        end

        if @orphans.empty?
            @topic.destroy
            redirect "/subjects"
        else
            erb :"/topics/reassign"
        end
    end
end