class SubjectsController < AppController
    # create routes ###############################

  
    # read routes #################################
    # also serves as topics index
    get '/subjects' do
        @subjects = Subject.all
        erb :"/subjects/index"
    end    
    
    # update routes ###############################

        
    # delete routes ###############################


    

end