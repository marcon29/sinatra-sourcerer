class SubjectsController < AppController
    # create routes ###############################
    get '/subjects/new' do        
        erb :"/subjects/new"
    end

    post '/subjects' do
        # binding.pry
        subject = Subject.create(params[:subject])

        if !params[:topic][:name].empty?
            topic = Topic.create(params[:topic])
            topic.subject = subject
            topic.save
        end
        
        redirect "/subjects"
    end
  
    # read routes #################################
    # also serves as topics index
    get '/subjects' do
        @subjects = Subject.all
        erb :"/subjects/index"
    end    
    
    # update routes ###############################
    get '/subjects/:id/edit' do
        @subject = Subject.find(params[:id])
        @topics = Topic.all        
        erb :"/subjects/edit"
    end
  
    patch '/subjects/:id' do
        subject = Subject.find(params[:id])
        subject.update(params[:subject])
        redirect "/subjects"
    end
        
    # delete routes ###############################


    

end