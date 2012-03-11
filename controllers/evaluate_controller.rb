require_relative 'application_controller'
require_relative '../model/evaluate_retrieve.rb'
require_relative '../model/modify_algorithms.rb'


class EvaluateController < ApplicationController

	#Displays 10 messages for classifier by default using the evaluate view
	get '/evaluate/?' do
		count = 10
		retriever = EvaluateRetrieve.new()
		
		if(params.has_key?('filter'))  
			@filters = filterFunction('filter')
		else
			@filters = ''
		end
		@messages = retriever.RetrieveClassificationObjects(count,@filters)
		mustache :evaluate
	end
	#Displays a given limit of messages from classifier using the evaluate view
	post '/evaluate/limit' do
		count = params.fetch("limit")
		retriever = EvaluateRetrieve.new()
		if(params.has_key?('filter'))
			@filters = filterFunction('filter')
		else
			@filters = ''
		end 
		@messages = retriever.RetrieveClassificationObjects(count,@filters)
		mustache :evaluate
	end

	get '/evaluate/edit' do
		mustache :edit_algorithms
	end

	post '/evaluate/modify' do
		param1 = params.fetch('parameter1')
		param2 = params.fetch('parameter2')
		param3 = params.fetch('parameter3')
		param4 = params.fetch('parameter4')
		param5 = params.fetch('parameter5')
		param6 = params.fetch('parameter6')
		modifier = ModifyAlgorithms.new()
		modifier.modifyAlgorithms(param1,param2,param3,param4,param5,param6)	
	end

	def filterFunction(filter)
		filters = params.fetch('filter') # Get the searchfilters.
			filters = filters.gsub(' ', ',') # Replaces all the ' ' with ','
			sanitized = filters.split(',')   # Splits all the strings at ','
			sanitized.delete_if(&:empty?)    # "Delete if empty"
			filters = ''
			sanitized.each do |value|
				filters = filters.concat(value).concat(',') # Join two strings together.
			end
			filters = filters.chomp(',')     # Remove all the ',' from filters.
			return filters
	end
end
