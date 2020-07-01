class SubjectsController < AppController
    # create routes ###############################
    get '/subjects/new' do        
        erb :"/subjects/new"
    end

    post '/subjects' do
        subject = Subject.new(params[:subject])

        if new_topic?
            topic = Topic.new(params[:topic])
            topic.subject = subject
            redirect "/subjects/new" if topic.invalid?
        end        
        
        if subject.save
            topic.save if topic
            redirect "/subjects"
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
        @subject = Subject.find_by_slug(params[:slug])
        @subjects = Subject.all        

        if params[:reassign]
            params[:reassign].each do |key, value|
                if value[:subject_id]
                    topic = Topic.find(value[:id])
                    topic.update(subject_id: value[:subject_id])
                end
            end
        else
            if new_topic?
                topic = Topic.new(params[:topic])
                topic.subject = @subject
                redirect "/subjects/#{params[:slug]}/edit" if topic.invalid?
            end        
            
            if @subject.update(params[:subject])
                topic.save if topic            
            else
                redirect "/subjects/#{params[:slug]}/edit"
            end
        end

        @orphans = find_orphans
        if @orphans.empty?
            redirect "/subjects"
        else                
            erb :"/subjects/reassign"
        end
    end    
        
    # delete routes ###############################
    delete '/subjects/:slug' do
        @subject = Subject.find_by_slug(params[:slug])
        @subjects = Subject.all

        if params[:reassign]
            params[:reassign].each do |key, value|
                if value[:subject_id]
                    topic = Topic.find(value[:id])
                    topic.update(subject_id: value[:subject_id])
                end
            end
        end

        @orphans = find_orphans
        if @orphans.empty?
            @subject.destroy
            redirect "/subjects"
        else
            erb :"/subjects/reassign"
        end
    end
end