require_relative 'application_controller'
require_relative '../model/corpus'

class TaggingController < ApplicationController
	get '/tweets' do
		@tweets = Corpus.tweets
		mustache :tweets
	end
end