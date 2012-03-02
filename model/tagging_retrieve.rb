class tagging_retrieve 
 
 include HTTParty
 base_uri "http://nosy.pspace.se/corpus"

 
 def RetrieveClassificationObjects(limit1)
  return self.class.get(:query => {:limit => limit1})
 end
 
end
