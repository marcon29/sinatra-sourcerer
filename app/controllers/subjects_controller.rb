class SubjectsController < AppController
    # create routes ###############################
    get '/subjects/new' do        
        erb :"/subjects/new"
    end

    post '/subjects' do
        subject = Subject.new(params[:subject])

        if subject.valid?
            if new_topic?
                topic = Topic.create(params[:topic])
                topic.subject = subject
                if topic.save
                    redirect "/subjects"
                else
                    redirect "/subjects/new"
                end
            else
                subject.save
                redirect "/subjects"
            end            
        else
            redirect "/subjects/new"
        end
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
        @subject = Subject.find_by_slug(params[:slug])
        @orphans = find_orphans(@subject)
        @subjects = Subject.all

        if params[:reassign]
            params[:reassign].each do |key, value|
                if value[:subject_id]
                    topic = Topic.find(value[:id])
                    topic.update(subject_id: value[:subject_id])
                end
            end
            @orphans = find_orphans(@subject)
        end

        if @orphans.empty?
            @subject.destroy
            redirect "/subjects"
        else
            erb :"/subjects/reassign"
        end
    end
end