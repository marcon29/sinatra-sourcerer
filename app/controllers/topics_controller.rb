require 'rack-flash'

class TopicsController < AppController
    use Rack::Flash

    # create routes ###############################
    get '/topics/new' do
        redirect '/' if !logged_in?
        user = current_user
        @subjects = user.subjects
        erb :"/topics/new"
    end

    post '/topics' do
        user = current_user
        topic = Topic.new(params[:topic])
        topic.user = user

        if new_subject?
            subject = Subject.new(params[:subject])
            subject.user = user
            subject.topics << topic
            
            if subject.invalid?
                flash[:message] = (
                    error_messages(topic) <<
                    error_messages(subject).drop(1)
                    ).join("<br>")
                redirect back
            end
        end

        if topic.save
            flash[:message] = "#{topic.formatted_name} created"
            flash[:message] << " within #{subject.formatted_name}" if subject
            redirect "/topics/#{topic.slug}"
        else
            flash[:message] = error_messages(topic).join("<br>")
            redirect back
        end
    end
  
    # read routes #################################
    # also serves as sources index
    get '/topics/:slug' do
        redirect '/' if !logged_in?
        @user = current_user
        @topic = user_item("topic")        
        @others_sources = others_unique_public_sources

        if @topic
            erb :"/topics/show"
        else
            flash[:message] = "That is not one of your topics"
            redirect back
        end
    end
    
    # update routes ###############################
    get '/topics/:slug/edit' do
        redirect '/' if !logged_in?
        @user = current_user
        @topic = user_item("topic")

        if @topic
            @subjects = @user.subjects
            erb :"/topics/edit"
        else
            flash[:message] = "That is not one of your topics"
            redirect back
        end        
    end
  
    patch '/topics/:slug' do
        @user = current_user
        topic = user_item("topic")

        if new_subject?
            subject = Subject.new(params[:subject])
            subject.user = @user
            subject.topics << topic
            
            if subject.invalid?
                flash[:message] = (
                    error_messages(topic) <<
                    error_messages(subject).drop(1)
                    ).join("<br>")
                redirect back
            end
        end

        if topic.update(params[:topic])
            flash[:message] = "#{topic.formatted_name} updated"
            flash[:message] << " within newly created #{subject.formatted_name}" if subject
            redirect "/topics/#{topic.slug}"
        else
            flash[:message] = error_messages(topic).join("<br>")
            redirect back
        end
    end
        
    # delete routes ###############################
    delete '/topics/:slug' do
        @user = current_user
        @topic = user_item("topic")
        @topics = @user.topics

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
        elsif @topics.count == 1
            flash[:message] = "Sources within #{@topic.formatted_name} have no place to go.<br>Either create a new topic to move them to, <br> or delete those sources first."
            redirect "/subjects"
        else
            erb :"/topics/reassign"
        end
    end
end
