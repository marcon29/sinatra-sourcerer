class AppController < Sinatra::Base
	configure do
		set :views, "app/views/"
		set :public_folder, "public"
		enable :sessions
		set :session_secret, "snufflebuff"
	end

	# app home page
	get '/' do
		redirect '/subjects' if logged_in?
		erb :index
	end

	# app helpers ###############################
	def new_subject?
		!params[:subject][:name].empty?
	end
  
	def new_topic?
		!params[:topic][:name].empty?
	end

	def find_orphans
		req_path = @env["REQUEST_PATH"].split("/")[1]
		req_meth = @env["REQUEST_METHOD"]
		if req_path == "topics"
			@topic.sources.select { |obj| obj.topic_ids.count <= 1 }
		elsif req_path == "subjects"
			if req_meth == "DELETE"
				@subject.topics
			else
				Topic.all.select { |obj| !obj.subject_id }
			end
		end
	end

	def formatted_date(date)
		date.strftime("%m/%d/%Y") if date
	end

	def error_messages(item)
		msgs = item.errors.messages.collect do |key, msg|
			messages = msg.collect { |m| "#{m}" }
			"#{item.class.name} #{key.capitalize}: #{messages.join(", ")}"
		end
 		msgs.unshift("Operation Failed")
	end

	# user helpers ###############################

	# def login(username, email, password)
    def login(user)
		if user && user.authenticate(params[:user][:password])
			session[:user_id] = user.id
		else
            flash[:message] = "We did not find a matching profile. Please sign up instead."
			redirect '/signup'
		end		
	end
  
	def current_user
		User.find(session[:user_id])
	end

	def logged_in?
		!!session[:user_id]
	end



end