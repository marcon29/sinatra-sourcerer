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
        user = User.new(params[:user])

        if user.save
            login(user)
            flash[:message] = "#{user.username} created"
            redirect "/subjects"
        else
            flash[:message] = error_messages(user).join("<br>")
            redirect '/signup'
        end
    end


    # login routes ################################################
    # display login form
    get '/login' do
        erb :"users/login"
    end

    # process login form
    post '/login' do
        if params[:user][:username] == "" || params[:user][:password] == ""            
            flash[:message] = "Operation Failed <br> Both Username and Password must be filled out"
            redirect '/login'
        else
            user = User.find_by(username: params[:user][:username])
            login(user)
            flash[:message] = "Welcome, #{user.first_name.capitalize}"
            redirect "/subjects"
        end
    end


    # update routes ###############################
    get '/users/:slug/edit' do
        erb :"/users/edit"
    end
    
    patch '/users/:slug' do
        user = current_user
        
        if user.update(params[:user])
            flash[:message] = "#{user.username} updated"
            redirect "/subjects"
        else
            flash[:message] = error_messages(user).join("<br>")
            redirect "/users/#{current_user.slug}/edit"
        end
    end

    
    # logout routes ################################################
    get '/logout' do
        session.clear
        redirect '/'
    end


    
    # delete routes ###############################
    # delete user (keep sources for others???)
    delete '/users/:slug' do
        # need to do this and decide what should happen
        redirect "/"
    end


  end