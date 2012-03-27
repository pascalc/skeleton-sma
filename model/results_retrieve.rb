require 'rubygems'
require 'httparty'

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
  def RetrieveJSON(path)
    url = 'http://nosy.pspace.se:7777/classify?'
    url.concat(path)
    jsonArray = HTTParty.get(url)
  end
end
