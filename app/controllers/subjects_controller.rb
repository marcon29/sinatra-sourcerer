require 'rack-flash'

class SubjectsController < AppController
    use Rack::Flash

    # create routes ###############################
    get '/subjects/new' do
        redirect '/' if !logged_in?
        erb :"/subjects/new"
    end

    post '/subjects' do
        user = current_user
        subject = Subject.new(params[:subject])
        subject.user = user

        if new_topic?
            topic = Topic.new(params[:topic])
            topic.subject = subject
            topic.user = user

            if topic.invalid?
                flash[:message] = error_messages(topic).join("<br>")
                redirect back
            end
        end
        
        if subject.save
            flash[:message] = "#{subject.formatted_name} created"
            if topic
                topic.save
                flash[:message] << " with #{topic.formatted_name}"
            end
            redirect "/subjects"
        else
            flash[:message] = error_messages(subject).join("<br>")
            redirect back
        end
    end
  
    # read routes #################################
    # also serves as topics index
    get '/subjects' do
        redirect '/' if !logged_in?
        user = current_user
        @subjects = user.subjects
        erb :"/subjects/index"
    end
    
    # update routes ###############################
    get '/subjects/:slug/edit' do
        redirect '/' if !logged_in?
        @user = current_user
        @subject = user_item("subject")

        if @subject
            @topics = @user.topics
            erb :"/subjects/edit"
        else
            flash[:message] = "That is not one of your subjects"
            redirect back
        end
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

                if topic.invalid?
                    flash[:message] = error_messages(topic).join("<br>")
                    redirect "/subjects/#{params[:slug]}/edit"
                end
            end
            
            if @subject.update(params[:subject])
                flash[:message] = "#{@subject.formatted_name} updated"
                if topic
                    topic.save
                    flash[:message] << " and #{topic.formatted_name} created"
                end
            else
                flash[:message] = error_messages(@subject).join("<br>")
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
            flash[:message] = "#{@subject.formatted_name} removed"
            redirect "/subjects"
        else
            erb :"/subjects/reassign"
        end
    end
end
