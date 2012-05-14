require_relative 'application_controller'
require_relative '../model/user.rb'

class UserController < ApplicationController
	# List users
	get '/users' do
		env['warden'].authenticate!
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
			puts "Verify user. The post data sent was: #{params.fetch('user')}, #{params.fetch('password')}"

    			u = User.authenticate(params['user'], params['password'])
    			if (u==nil)
				if(session[:fails] != nil)
				   session[:fails] = session[:fails] + 1
				   @nr_fails = session[:fails]
				   puts @nr_fails
				else
					session[:fails] = 1
				end
				puts "A user failed to login #{session[:fails]} many times!"
				redirect "/login"
			else
				session[:fails] = 0
				@nr_fails = session[:fails]
				env['warden'].set_user(u)
				puts "A user has logged in, user: #{env['warden'].user.email}"
				if(session[:redirect] != nil)
					redirect session[:redirect]#This redirects to the wanted place	
				else
					redirect "/tagging"# Otherwise redirect to another place
				end
			end
		else
			puts "Intruder Alert!"
			"Hackers begone!"
		end
	end

	post '/logout' do
		env['warden'].logout
		mustache :logout		
	end
	get '/logout' do
		env['warden'].logout
		mustache :logout
	end
end
