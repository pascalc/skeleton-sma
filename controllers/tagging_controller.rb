require_relative 'application_controller'
require_relative '../model/tagging_retrieve'

class TaggingController < ApplicationController	

	post'/tagging/limit' do
		"Working! You wanted to get: #{params.fetch("limit")} new messeges."
		count  = params.fetch("limit")
		@filters = params.fetch("filter");
		puts @filters
		redirect "/tagging/#{count}"
	end
	
	#This should dispay the messages got from the corpus 
	get '/tagging/:limit' do 
		r = Retrieve.new()
		@messages = r.RetrieveClassificationObjects(params[:limit])
						
		@messages.each_with_index do |item,index|
			#get the tags for the items here
		end
		mustache :tagging
	end
		
	#This route will commit a json object to the training set so that the algorythms can work with it.
	#If the ID was not found in this variable the user should be notified.
	#
	#After this commit it done the session[:msgs] should be updated and the tagging page should be loaded
	post %r{/tagging/commit/(\d{1,99999})} do |id|
		puts "Working, commit id was #{id} and the tags string should have been #{params.fetch('tags')}"
	end

	#Removes a message form the database and from the session[:msgs]
	#
	#After this discard it done the session[:msgs] should be updated and the tagging page should be loaded
	post %r{/tagging/discard/(\d{1,99999})} do |id|
		puts "Discard working, discard id was #{id}"
	end
end
