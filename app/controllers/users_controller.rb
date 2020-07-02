require 'rack-flash'

class UsersController < AppController
    use Rack::Flash

    # signup routes ################################################
    # display signup form route
    get '/signup' do
        erb :"users/signup"
    end

    # process signup form route
    post '/signup' do
        redirect '/subjects'
    end


    # login routes ################################################
    # display login form
    get '/login' do
        erb :"users/login"
    end

    # process login form - add the user_id to the sessions hash
    post '/login' do
        redirect '/subjects'
    end

    
    # user home routes ################################################
    # shows only the signed in users's sources
    get "/users/:slug" do
        # this should go to the subjects index - need this route?
    end


    # update routes ###############################
    get '/users/:slug/edit' do            
        erb :"/users/edit"
    end
    
    patch '/users/:slug' do
        redirect "/subjects"
    end

    
    # logout routes ################################################
    # process logout form (in layout.erb right now)
    get '/logout' do
        redirect '/'
    end


    
    # delete routes ###############################
    # delete user (keep sources for others???)
    delete '/users/:slug' do
        redirect "/"        
    end


  end