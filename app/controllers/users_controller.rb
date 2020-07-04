require 'rack-flash'

class UsersController < AppController
    use Rack::Flash

    # signup routes ################################################
    get '/signup' do
        redirect '/subjects' if logged_in?
        erb :"users/signup"
    end

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
    get '/login' do
        redirect '/subjects' if logged_in?
        erb :"users/login"
    end

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
        redirect '/subjects' if !logged_in?
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
        redirect '/' if !logged_in?
        session.delete(:user_id)
        redirect '/'
    end
  end