require 'rubygems'
require 'httparty'
require 'net/http'

class ResultsRetrieve
  def RetrieveClassificationObjects(limit1,filter)
    if(filter.strip.empty?)
      #Use this as preliminary adress
      jsonArray = HTTParty.get("http://nosy.pspace.se:7777/classify?limit=#{limit1}")
      puts "@filters was empty"
    else
      #Use this as preliminary adress
      jsonArray = HTTParty.get("http://nosy.pspace.se:7777/classify?thresholds=#{filter}&limit=#{limit1}")
      puts "@filters was #{filter}"
    end
    return jsonArray      
  end
  def RetrieveJSON(filter, startTime, endTime, limit1)
    jsonArray = HTTParty.get("http://nosy.pspace.se:7777/classify?thresholds=#{filter}&start_time=#{startTime}&end_time=#{endTime}&limit=#{limit1}")
    return jsonArray
  end
end
