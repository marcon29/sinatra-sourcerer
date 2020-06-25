class SubjectsController < AppController
    # create routes ###############################

  
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