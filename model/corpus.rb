require 'httparty'

class Corpus
	include HTTParty
	base_uri "http://nosy.pspace.se/corpus"
end