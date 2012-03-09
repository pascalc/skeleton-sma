require 'rubygems'
require 'httparty'

class EvaluateRetrieve
    def RetrieveClassificationObjects(limit1,filter)
	
	if(filter.strip.empty?)
		#Use this as preliminary adress
		jsonArray = HTTParty.get("http://nosy.pspace.se:8888/corpus?count=#{limit1}")
		puts "@filters was empty"
	else
		#Use this as preliminary adress
		jsonArray = HTTParty.get("http://nosy.pspace.se:8888/corpus?keywords=#{filter}&count=#{limit1}")
		puts "@filters was #{filter}"
	end
        return jsonArray      
    end
end
