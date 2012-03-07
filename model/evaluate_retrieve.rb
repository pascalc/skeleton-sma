require 'rubygems'
require 'httparty'

class EvaluateRetrieve
    def RetrieveClassificationObjects(limit1)
	#Use this as preliminary adress
	jsonArray = HTTParty.get("http://nosy.pspace.se:8888/corpus?count=#{limit1}")
        return jsonArray   
    end
end
