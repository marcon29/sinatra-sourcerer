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
            

end