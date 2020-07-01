class AppController < Sinatra::Base
    configure do
        set :views, "app/views/"
        set :public_folder, "public"        
        enable :sessions
        # set :session_secret, "session_key"
    end

    # app home page
    get '/' do
        erb :index
    end


    # helpers ###############################
    def new_subject?
        !params[:subject][:name].empty?
    end
    
    def new_topic?
        !params[:topic][:name].empty?
    end

    # def find_orphans(item)
    def find_orphans
        req_path = @env["REQUEST_PATH"].split("/")[1]
        req_meth = @env["REQUEST_METHOD"]
        if req_path == "topics"
            @topic.sources.select { |obj| obj.topic_ids.count <= 1 }
        elsif req_path == "subjects"
            if req_meth == "DELETE"
                @subject.topics
            else
                Topic.all.select { |obj| !obj.subject_id }
            end
        end
    end

    def formatted_date(date)
        date.strftime("%m/%d/%Y") if date
    end


    
            

end