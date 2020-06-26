class SourcesController < AppController
    # create routes ###############################
    get '/sources/new' do
        @subjects = Subject.all
        @topics = Topic.all
        erb :"/sources/new"
    end

    post '/sources' do
        redirect "/sources/new" if no_topic_assigned?
        source = Source.create(params[:source])

        if new_topic?
            redirect "/sources/new" if no_subject_assigned?
            topic = Topic.create(params[:topic])

            if new_subject?
                subject = Subject.create(params[:subject])
                subject.topics << topic
            end
            
            topic.sources << source
        end

        redirect "/sources/#{source.id}"
    end
  
    # read routes #################################  
    get '/sources/:id' do
        @source = Source.find(params[:id])
        erb :"/sources/show"
    end
  
    # update routes ###############################
    get '/sources/:id/edit' do
        @source = Source.find(params[:id])
        @topics = Topic.all        
        erb :"/sources/edit"
    end
  
    patch '/sources/:id' do
        source = Source.find(params[:id])
        source.update(params[:source])
        redirect "/sources/#{source.id}"
    end
  
  
    # delete routes ###############################
  end