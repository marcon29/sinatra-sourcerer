class AppController < Sinatra::Base
    configure do
        set :views, "app/views/"
        set :public_folder, "public"        
        # enable :sessions
        # set :session_secret, "session_key"
    end

    # app home page
    get '/' do
        erb :index
    end


    # helpers ###############################
    def topics_in_subject(subj)
        Topic.all.select { |t| t.subject == subj }
    end

    def sources_in_topic(top)
        Source.all.select { |s| s.topics.include?(top) }
    end

    def no_subject_assigned?
        !params[:topic][:subject_id] && !new_subject?
    end
    
    def no_topic_assigned?
        !params[:source][:topic_ids] && !new_topic?
    end

    def new_subject?
        !params[:subject][:name].empty?
    end
    
    def new_topic?
        !params[:topic][:name].empty?
    end

    def find_orphans(item)
        req_type = @env["REQUEST_PATH"].split("/")[1]
        if req_type == "topics"
            sources_in_topic(item).select { |obj| obj.topic_ids.count <= 1 }
        elsif req_type == "subjects"
            topics_in_subject(item)
        end
    end

    def formatted_date(date)
        date.strftime("%m/%d/%Y")
    end


    
            

end