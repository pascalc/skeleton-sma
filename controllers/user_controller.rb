require_relative 'application_controller'
require_relative '../model/user.rb'

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

	# Edit a user
	put '/user' do
		"Creates a user"
	end

	# Make a new user
	post '/user' do
		"Made a new user"
	end
	
	get '/login' do
		mustache :login
	end

	post '/login' do
		if(params.has_key?('user')&&params.has_key?('password'))
			"Verify user. The post data sent was: #{params.fetch('user')}, #{params.fetch('password')}"

		#User.authenticate(params.fetch('user'),params.fetch('password'))
		else
			"Intruder Alert!"
		end
	end

	post '/logout' do
		"Show the login page"
	end
end
