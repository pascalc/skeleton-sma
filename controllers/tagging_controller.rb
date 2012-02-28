require_relative 'application_controller'

class TaggingController < ApplicationController
	

	#in general define exactly what these does
	#how should they work, should they be changed
	#should it be a web request to the server with the edit request?
	#should it be run in a hidden frame on the /tagging side and be changed with JQuary?
	get '/tagging?limit=:number' do

	end

	get '/tagging/edit?id=:id'

	end
	#update what?
	post '/tagging/update' do

	end
end
