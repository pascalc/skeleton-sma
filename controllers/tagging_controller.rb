require_relative 'application_controller'
require_relative '../model/retrieve'

class TaggingController < ApplicationController
	
	
	
	#This route should pull json object from the corpus and dispaly them in the appropriate
	#layout.
	#All posts should be stored in a session variable namely session[:msgs]
	post'/tagging/limit' do
		"Working! You wanted to get: #{params.fetch("limit")} new messeges."
		count  = params.fetch("limit")
		r = Retrieve.new()
		@tweets = r.RetrieveClassificationObjects(count)
	end
	
	#This should dispay the messages that session[:msgs] contains on the same page
	#as the %r{/tagging/limit/(\d{1,99999})} displays
	get '/tagging' do 
		session[:msgs] = @tweets
		#if the session[:msgs] is empty we should get some
		mustache :tagging
	end
		
	#This route will commit a json object to the training set so that the algorythms can work with it.
	#The id should be a ID of an object in the session[:msgs]
	#If the ID was not found in this variable the user should be notified.
	#
	#After this commit it done the session[:msgs] should be updated and the tagging page should be loaded
	post %r{/tagging/commit/(\d{1,99999})} do |id|
		"Working, commit id was #{id}"
	end

	#Removes a message form the database and from the session[:msgs]
	#
	#After this discard it done the session[:msgs] should be updated and the tagging page should be loaded
	post %r{/tagging/discard/(\d{1,99999})} do |id|
		"Working, discard id was #{id}"
	end
end
