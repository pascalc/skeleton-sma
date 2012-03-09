require_relative 'application_controller'
require_relative '../model/evaluate_retrieve.rb'

class EvaluateController < ApplicationController

	#Displays 10 messages for classifier by default using the evaluate view
	get '/evaluate' do
		count = 10
		retriever = EvaluateRetrieve.new()
		
		if(params.has_key?('filter'))
			filters = params.fetch('filter')
			filters = filters.gsub(' ', ',')
			sanitized = filters.split(',')
			sanitized.delete_if(&:empty?)
			filters = ''
			sanitized.each do |value|
				filters = filters.concat(value).concat(',')
			end
			filters = filters.chomp(',')
			@filters = filters
		else
			@filters = ''
		end
		@messages = retriever.RetrieveClassificationObjects(count,@filters)
		puts @messages
		mustache :evaluate
	end
	#Displays a given limit of messages from classifier using the evaluate view
	post '/evaluate/limit' do
		count = params.fetch("limit")
		retriever = EvaluateRetrieve.new()
		if(params.has_key?('filter'))
			filters = params.fetch('filter')
			filters = filters.gsub(' ', ',')
			sanitized = filters.split(',')
			sanitized.delete_if(&:empty?)
			filters = ''
			sanitized.each do |value|
				filters = filters.concat(value).concat(',')
			end
			filters = filters.chomp(',')
			@filters = filters
		else
			@filters = ''
		end
		@messages = retriever.RetrieveClassificationObjects(count,@filters)
		puts @messages
		mustache :evaluate
	end
end
