require 'rack-flash'

class SourcesController < AppController
    use Rack::Flash

    # create routes ###############################
    get '/sources/new' do
        redirect '/' if !logged_in?
        user = current_user
        @subjects = user.subjects
        @topics = user.topics
        erb :"/sources/new"
    end

    post '/sources' do
        user = current_user
        source = Source.new(params[:source])
        source.user = user
        
        if new_topic?
            topic = Topic.new(params[:topic])
            topic.user = user
            
            if new_subject?
                subject = Subject.new(params[:subject])
                subject.user = user
                subject.topics << topic

                if subject.invalid?
                    source.valid?
                    flash[:message] = (
                        error_messages(source) <<
                        error_messages(topic).drop(1) <<
                        error_messages(subject).drop(1)
                        ).join("<br>")
                    redirect back
                end
            end

            source.topics << topic

            if topic.invalid?
                source.valid?
                flash[:message] = (
                    error_messages(source) <<
                    error_messages(topic).drop(1)
                    ).join("<br>")
                redirect back
            end
        end

        if source.save
            flash[:message] = "#{source.formatted_name} created"
            flash[:message] << " within #{topic.formatted_name}" if topic
            flash[:message] << " within #{subject.formatted_name}" if subject
            redirect "/sources/#{source.slug}"
        else
            flash[:message] = error_messages(source).join("<br>")
            redirect back
        end
    end
  
    # read routes #################################
    get '/sources/:slug' do
        redirect '/' if !logged_in?
        @user = current_user
        @source = user_item("source")

        if @source
            erb :"/sources/show"
        else
            flash[:message] = "That is not one of your sources"
            redirect back
        end
        
    end
  
    # update routes ###############################
    get '/sources/:slug/edit' do
        redirect '/' if !logged_in?
        @user = current_user
        @source = user_item("source")

        if @source
            @subjects = @user.subjects
            @topics = @user.topics
            erb :"/sources/edit"
        else
            flash[:message] = "CHECK That is not one of your sources"
            redirect back
        end  
        
    end
  
    patch '/sources/:slug' do
        source = Source.find_by_slug(params[:slug])
        source.update(params[:source])
        
        if source.invalid?
            flash[:message] = error_messages(source).join("<br>")
            redirect "/sources/#{params[:slug]}/edit"
        end

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
                    redirect "/sources/#{params[:slug]}/edit"
                end
            end

            source.topics << topic if topic.valid?
            if topic.invalid?
                source.valid?
                flash[:message] = (
                    error_messages(source) <<
                    error_messages(topic).drop(1)
                    ).join("<br>")
                redirect "/sources/#{params[:slug]}/edit"
            end
        end

        if source.save
            flash[:message] = "#{source.formatted_name} updated"
            flash[:message] << " within newly created #{topic.formatted_name}" if topic
            flash[:message] << " within newly created #{subject.formatted_name}" if subject
            redirect "/sources/#{source.slug}"
        else
            flash[:message] = error_messages(source).join("<br>")
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