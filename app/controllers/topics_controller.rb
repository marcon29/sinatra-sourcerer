require 'rack-flash'

class TopicsController < AppController
    use Rack::Flash

    # create routes ###############################
    get '/topics/new' do
        @subjects = Subject.all
        erb :"/topics/new"
    end

    post '/topics' do
        topic = Topic.new(params[:topic])

        if new_subject?
            subject = Subject.new(params[:subject])
            subject.topics << topic

            if subject.invalid?
                flash[:message] = (
                    error_messages(topic) <<
                    error_messages(subject).drop(1)
                    ).join("<br>")
                redirect "/topics/new"
            end
        end

        if topic.save
            flash[:message] = "#{topic.formatted_name} created"
            flash[:message] << " within #{subject.formatted_name}" if subject
            redirect "/topics/#{topic.slug}"
        else
            flash[:message] = error_messages(topic).join("<br>")
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
            
            if subject.invalid?
                flash[:message] = (
                    error_messages(topic) <<
                    error_messages(subject).drop(1)
                    ).join("<br>")
                redirect "/topics/#{params[:slug]}/edit"
            end
        end

        if topic.update(params[:topic])
            flash[:message] = "#{topic.formatted_name} updated"
            flash[:message] << " within newly created #{subject.formatted_name}" if subject
            redirect "/topics/#{topic.slug}"
        else
            flash[:message] = error_messages(topic).join("<br>")
            redirect "/topics/#{params[:slug]}/edit"
        end
    end
        
    # delete routes ###############################
    delete '/topics/:slug' do
        @topic = Topic.find_by_slug(params[:slug])
        @topics = Topic.all

        if params[:reassign]
            params[:reassign].each do |key, value|
                if value[:topic_ids]
                    source = Source.find(value[:id])
                    source.update(topic_ids: value[:topic_ids])
                end
            end
        end

        @orphans = find_orphans
        if @orphans.empty?
            @topic.destroy
            flash[:message] = "#{@topic.formatted_name} removed"
            redirect "/subjects"
        else
            erb :"/topics/reassign"
        end
    end
end
