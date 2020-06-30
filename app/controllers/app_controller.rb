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
    def new_subject?
        !params[:subject][:name].empty?
    end
    
    def new_topic?
        !params[:topic][:name].empty?
    end

    def find_orphans(item)
        req_type = @env["REQUEST_PATH"].split("/")[1]
        if req_type == "topics"
            item.sources.select { |obj| obj.topic_ids.count <= 1 }
        elsif req_type == "subjects"
            item.topics
        end
    end

    def formatted_date(date)
        date.strftime("%m/%d/%Y") if date
    end


    
            

end