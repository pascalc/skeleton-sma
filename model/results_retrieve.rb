require 'rubygems'
require 'httparty'
require 'net/http'

class ResultsRetrieve
  def RetrieveCO(filter,limit)
    if(filter.strip.empty?)
      #Use this as preliminary adress
      jsonArray = HTTParty.get("http://nosy.pspace.se:7777/classify?limit=#{limit}")
      puts "@filters was empty"
    else
      #Use this as preliminary adress
      jsonArray = HTTParty.get("http://nosy.pspace.se:7777/classify?thresholds=#{filter}&limit=#{limit}")
      puts "@filters was #{filter}"
    end
    return jsonArray      
  end
  def RetrieveCOIntervall(filter, startTime, endTime, limit)
    jsonArray = HTTParty.get("http://nosy.pspace.se:7777/classify?thresholds=#{filter}&start_time=#{startTime}&end_time=#{endTime}&limit=#{limit}")
    return jsonArray
  end
end
