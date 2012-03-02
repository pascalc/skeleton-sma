require 'rubygems'
require 'httparty'

class Retrieve
    def RetrieveClassificationObjects(limit1)
	jsonArray = HTTParty.get("http://nosy.pspace.se:8888/corpus?count=#{limit1}")

	#todo make to ruby array
        return jsonArray   
    end
end
