require 'rack-flash'

class SourcesController < AppController
    use Rack::Flash

    # create routes ###############################
    get '/users/new' do
        erb :"/users/new"
    end

    post '/users' do
        redirect "/users/#{user.slug}"
    end
  
    # read routes #################################
    get '/users/:slug' do
        erb :"/users/show"
    end
  
    # update routes ###############################
    get '/users/:slug/edit' do
        erb :"/users/edit"
    end
  
    patch '/users/:slug' do
        redirect "/sources/#{user.slug}"
    end
    
    # delete routes ###############################
    delete '/users/:slug' do
        redirect "/"
    end
  end