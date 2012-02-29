require_relative 'application_controller'

class UserController < ApplicationController
	# List users
	get '/users' do
		"List users"
	end

	# Show one user
	get '/user/:id' do |id|
		"Show user #{id}"
	end

	# Edit a user
	put '/user/:id' do |id|
		"Edit user #{id}"
	end

	# Make a new user
	post '/user' do
		"Made a new user"
	end
	#ignore this section it should be moved to the tagging controller

	#This route should pull json object from the corpus and dispaly them in the appropriate
	#layout.
	#All posts should be stored in a session variable namely session[:msgs]
	get %r{/tagging/limit/(\d{1,99999})} do |limit|
  		mustache :tagging
	end
	
	#This should dispay the messages that session[:msgs] contains on the same page
	#as the %r{/tagging/limit/(\d{1,99999})} displays
	get '/tagging' do 
		"Working!"
	end
	
	#This route will commit a json object to the training set so that the algorythms can work with it.
	#The id should be a ID of an object in the session[:msgs]
	#If the ID was not found in this variable the user should be notified.
	#
	#After this commit it done the session[:msgs] should be updated and the tagging page should be loaded
	get %r{/tagging/commit/(\d{1,99999})} do |id|
		"Working, commit id was #{id}"
	end

	#Removes a message form the database and from the session[:msgs]
	#
	#After this discard it done the session[:msgs] should be updated and the tagging page should be loaded
	get %r{/tagging/discard/(\d{1,99999})} do |id|
		"Working, discard id was #{id}"
	end

	#stop ignore
end
