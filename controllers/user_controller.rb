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
	#ignore this section
	get %r{/tagging/limit/(\d{0,99999})} do |limit|
  		"Working, limit was #{limit}"
	end
	#stop ignore
end
