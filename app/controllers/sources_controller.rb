require 'rack-flash'

class SourcesController < AppController
    use Rack::Flash

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
                if subject.invalid?
                    source.valid?                    
                    flash[:message] = (
                        error_messages(source) <<
                        error_messages(topic).drop(1) <<
                        error_messages(subject).drop(1)
                        ).join("<br>")
                    redirect "/sources/new" 
                end
            end

            source.topics << topic
            if topic.invalid?
                source.valid?
                flash[:message] = (
                    error_messages(source) <<
                    error_messages(topic).drop(1)
                    ).join("<br>")
                redirect "/sources/new"
            end
        end

        if source.save
            flash[:message] = "#{source.formatted_name} created"
            flash[:message] << " within #{topic.formatted_name}" if topic
            flash[:message] << " within #{subject.formatted_name}" if subject
            redirect "/sources/#{source.slug}"
        else
            flash[:message] = error_messages(source).join("<br>")
            binding.pry
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
            flash[:message] = "#{source.formatted_name} updated"
            flash[:message] << " within newly created #{topic.formatted_name}" if topic
            flash[:message] << " within newly created #{subject.formatted_name}" if subject
            redirect "/sources/#{source.slug}"
        else
            redirect "/sources/#{params[:slug]}/edit"
        end
    end
  
  
    # delete routes ###############################
    delete '/sources/:slug' do
        source = Source.find_by_slug(params[:slug])
        source.destroy
        flash[:message] = "#{source.formatted_name} removed"
        redirect "/subjects"        
    end
  end