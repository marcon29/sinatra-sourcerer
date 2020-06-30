class SourcesController < AppController
    # create routes ###############################
    get '/sources/new' do
        @subjects = Subject.all
        @topics = Topic.all
        erb :"/sources/new"
    end

    post '/sources' do
        source = Source.new(params[:source])
        
        if new_topic?
            topic = Topic.new(params[:topic])
            
            if new_subject?
                subject = Subject.new(params[:subject])
                subject.topics << topic
                redirect "/sources/new" if subject.invalid?
            end

            source.topics << topic    
            redirect "/sources/new" if topic.invalid?
        end

        if source.save
            redirect "/sources/#{source.slug}"
        else
            redirect "/sources/new"
        end
    end
  
    # read routes #################################  
    get '/sources/:slug' do
        @source = Source.find_by_slug(params[:slug])
        erb :"/sources/show"
    end
  
    # update routes ###############################
    get '/sources/:slug/edit' do
        @source = Source.find_by_slug(params[:slug])
        @subjects = Subject.all
        @topics = Topic.all
        erb :"/sources/edit"
    end
  
    patch '/sources/:slug' do
        source = Source.find_by_slug(params[:slug])
        source.update(params[:source])
        redirect "/sources/#{params[:slug]}/edit" if source.invalid?

        if new_topic?
            topic = Topic.new(params[:topic])
            
            if new_subject?
                subject = Subject.new(params[:subject])
                subject.topics << topic
                redirect "/sources/#{params[:slug]}/edit" if subject.invalid?
            end

            source.topics << topic
            redirect "/sources/#{params[:slug]}/edit" if topic.invalid?
        end

        if source.save
            redirect "/sources/#{source.slug}"
        else
            redirect "/sources/#{params[:slug]}/edit"
        end
    end
  
  
    # delete routes ###############################
    delete '/sources/:slug' do
        source = Source.find_by_slug(params[:slug])
        source.destroy
        redirect "/subjects"        
    end
  end