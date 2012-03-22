require 'rubygems'
require 'httparty'

class Retrieve
    def RetrieveClassificationObjects(limit1,filter)

	
	if(filter.strip.empty?)
		jsonArray = HTTParty.get("http://nosy.pspace.se:8888/corpus?limit=#{limit1}")
		puts "@filters was empty"
	else
		jsonArray = HTTParty.get("http://nosy.pspace.se:8888/corpus?keywords=#{filter}&limit=#{limit1}")
		puts "@filters was #{filter}"
	end
        return jsonArray   
    end
end
