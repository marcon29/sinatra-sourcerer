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

        redirect "/sources/#{source.slug}"
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

        if new_topic?
            redirect "/sources/new" if no_subject_assigned?
            topic = Topic.create(params[:topic])

            if new_subject?
                subject = Subject.create(params[:subject])
                subject.topics << topic
            end
            
            topic.sources << source
        end

        redirect "/sources/#{source.slug}"
    end
  
  
    # delete routes ###############################

  end