class AppController < Sinatra::Base
    configure do
        set :views, "app/views/"
        # set :public_folder, "public"
        # enable :sessions
        # set :session_secret, "session_key"
    end

    # app home page
    get '/' do
        erb :index
    end
end