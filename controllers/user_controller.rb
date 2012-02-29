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
	get %r{/tagging/limit/(\d{1,99999})} do |limit|
  		"Working, limit was #{limit}"
	end

	get %r{/tagging/commit/(\d{1,99999})} do |id|
		"Working, commit id was #{id}"
	end

	get %r{/tagging/discard/(\d{1,99999})} do |id|
		"Working, discard id was #{id}"
	end
	#stop ignore
end
