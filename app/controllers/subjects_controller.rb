class SubjectsController < AppController
    # create routes ###############################

  
    # read routes #################################
    # also serves as topics index
    get '/subjects' do
        @subjects = Subject.all
        # @topics = Topic.all
        # @sources = Source.all

        erb :"/subjects/index"
    end
    
    # get '/subjects/:id' do
    #     @subject = Subject.find(params[:id])
    #     erb :"/subjects/show"
    # end
    
    # update routes ###############################

        
    # delete routes ###############################


    

end