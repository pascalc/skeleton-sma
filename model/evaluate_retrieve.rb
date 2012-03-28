require 'rubygems'
require 'httparty'

class EvaluateRetrieve
    def RetrieveClassificationObjects(limit1,filter)
	if(filter.strip.empty?)
		#Use this as preliminary adress

		#jsonArray = HTTParty.get("http://nosy.pspace.se:8888/corpus?count=#{limit1}")
		#http://nosy.pspace.se:7777/classify?thresholds=%7B%22english%22:0.9%7D&start_time=1332667503&end_time=1332685496&limit=500
		jsonArray = HTTParty.get("http://nosy.pspace.se:7777/classify?limit=#{limit1}")
		puts "@filters was empty"
	else
		#Use this as preliminary adress
		#jsonArray = HTTParty.get("http://nosy.pspace.se:8888/corpus?keywords=#{filter}&count=#{limit1}")
		jsonArray = HTTParty.get("http://nosy.pspace.se:7777/classify?thresholds=#{filter}&limit=#{limit1}")
		puts "@filters was #{filter}"
	end
        return jsonArray      
    end
end
