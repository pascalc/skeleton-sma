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
			puts "Verify user. The post data sent was: #{params.fetch('user')}, #{params.fetch('password')}"

    			u = User.authenticate(params['user'], params['password'])
    			if (u==nil)
				if(session[:fails] != nil)
				   session[:fails] = session[:fails] + 1
				else
					session[:fails] = 1
				end
				puts "A user failed to login #{session[:fails]} many times!"
				redirect "/login"
			else
				session[:fails] = 0
				env['warden'].set_user(u)
				puts "A user has logged in, user: #{env['warden'].user.email}"
				if(session[:redirect] != nil)
					redirect session[:redirect]			
				else
					redirect "/tagging"
				end
				#TODO forward to the right place
			end
		else
			puts "Intruder Alert!"
			"Hackers begone!"
		end
	end

	post '/logout' do
		env['warden'].logout
		
	end
end
