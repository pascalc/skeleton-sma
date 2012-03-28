require_relative 'application_controller'

class UserController < ApplicationController
	# List users
	get '/users' do
		@users = ['Pascal', 'Johan', 'Mikaela']
		mustache :users
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
end
