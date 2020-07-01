require 'rack-flash'

class SubjectsController < AppController
    use Rack::Flash

    # create routes ###############################
    get '/subjects/new' do        
        erb :"/subjects/new"
    end

    post '/subjects' do
        subject = Subject.new(params[:subject])

        if new_topic?
            topic = Topic.new(params[:topic])
            topic.subject = subject

            if topic.invalid?
                flash[:message] = error_messages(topic).join("<br>")
                redirect "/subjects/new"
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
                flash[:message] = "#{@subject.formatted_name} updated"
                if topic
                    topic.save
                    flash[:message] << " and #{topic.formatted_name} created"
                end
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
            flash[:message] = "#{@subject.formatted_name} removed"
            redirect "/subjects"
        else
            erb :"/subjects/reassign"
        end
    end
end