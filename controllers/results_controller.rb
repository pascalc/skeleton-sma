require_relative 'application_controller'
require_relative '../model/results_retrieve.rb'
require 'json'

class ResultsController < ApplicationController

  #Displays 10 messages for classifier by default using the evaluate view
  get '/results/?' do
    count = 10
    retriever = ResultsRetrieve.new()

    if(params.has_key?('filter'))  
      @filters = filterFunction('filter')
    else
      @filters = ''
    end
      @messages = retriever.RetrieveCO(@filters, count)
      mustache :results
  end

  post '/results' do
    count = params.fetch('limit')
    retriever = ResultsRetrieve.new()
    if(params.has_key?('filter'))
      @filters = filterFunction('filter')
    else
      @filters = ''
    end
    @messages = retriever.RetrieveCO(@filters,count)
    @keywords = params.fetch('filter')
    mustache :results
  end
	
  #Displays a given limit of messages from classifier using the evaluate view
  post '/results/limit' do
    count = params.fetch('limit')
    retriever = ResultsRetrieve.new()
    if(params.has_key?('filter'))
      @filters = filterFunction('filter')
    else
      @filters = ''
    end
    @messages = retriever.RetrieveCO(@filters,count)
    @keywords = params.fetch('filter')
    mustache :results
  end

  #this temporary sollution
  get '/results/static' do
    mustache :static_graph
  end

  #post already set tags to static graph page
  post '/results/static' do
    mustache :static_graph
  end

  #this temporary sollution
  get '/results/dynamic' do
    mustache :dynamic_graph
  end

  #post already set tags to dynamic graph page
  post '/results/dynamic' do
    mustache :dynamic_graph
  end

  #post already set tags to google map page
  get '/results/map' do
    mustache :google_map
  end

  post '/results/map' do
    mustache :google_map
  end

  get '/results/data?' do
    content_type :json
    retriever = ResultsRetrieve.new()
    thresholds = params[:thresholds]
    thresholds = thresholds.gsub('"','%22')
    thresholds = thresholds.gsub('{','%7B')
    thresholds = thresholds.gsub('}','%7D')
    startTime = params[:start_time]
    endTime = params[:end_time]
    limit = params[:limit]
    jsonArray = retriever.RetrieveCOIntervall(thresholds,startTime,endTime,limit)
    puts jsonArray
    jsonArray.to_json
  end

  def filterFunction(filter)
    filters = params.fetch('filter') # Get the searchfilters.
    filters = filters.gsub(' ', ',') # Replaces all the ' ' with ','
    sanitized = filters.split(',')   # Splits all the strings at ','
    sanitized.delete_if(&:empty?)    # "Delete if empty"
    filters = ''
    filters.concat('%7B')

    sanitized.each do |value|
      tmp = value.split(':')
      if tmp.length == 1
        tmp = [tmp[0], "0.0"]
      end
      # Join two strings together
      filters = filters.concat('%22').concat(tmp[0]).concat('%22:').concat(tmp[1]).concat(',') 
    end
    filters = filters.chomp(',')     # Remove the last ',' from filters.
    filters.concat('%7D')
    puts filters
    return filters
  end
end
