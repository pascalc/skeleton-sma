require_relative 'application_controller'
require_relative '../model/evaluate_retrieve.rb'

class EvaluateController < ApplicationController

	#Displays 10 messages for classifier by default using the evaluate view
	get '/evaluate' do
		count = 10
		mustache :evaluate
	end
	#Displays a given limit of messages from classifier using the evaluate view
	post '/evaluate/limit' do
		count = params.fetch("limit");
		mustache :evaluate
	end

	#post '/evaluate/:threshold' do
	#	count = params.fetch("threshold");
	#	mustache :evaluate
	#end
end
