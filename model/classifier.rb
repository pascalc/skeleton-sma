require 'httparty'

class Classifier
	include HTTParty
	base_uri "http://nosy.pspace.se/classifier"
end