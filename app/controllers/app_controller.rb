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
				@topics.select { |obj| !obj.subject_id }				
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

	def user_item(item)
		case item
			when "subject"
				@user.subjects.find { |sub| sub.slug == params[:slug] }
			when "topic"
				@user.topics.find { |top| top.slug == params[:slug] }
			when "source"
				@user.sources.find { |src| src.slug == params[:slug] }
		end		
	end
	
	# topic helpers ###############################

	def others_same_name_topics
		Topic.all.select { |top| top.formatted_name == @topic.formatted_name && top != @topic }
   end

   def all_sources_urls
	   @topic.sources.collect { |src| src.url }
   end

   def others_unique_public_sources 
	   sources = []
	   others_same_name_topics.each do |top|
		   top.sources.each do |src| 
			   if src.public == true && !all_sources_urls.include?(src.url)
				   sources << src
			   end
		   end
	   end
	   sources
   end
   

	# delete this method when done testing
	def check_others_sources
		others_unique_public_sources.collect { |src| src.name }
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