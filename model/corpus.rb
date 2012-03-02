require 'httparty'

class Corpus
	include HTTParty
	base_uri "http://nosy.pspace.se:8888/"

  def self.tweets
      self.get "/corpus"
  end
end

=begin
    USAGE:
        $ irb -I .
        > Corpus.tweets
    RETURNS
        [{"source"=>"twitter",
          "last_modified"=>"2012-03-02T14:17:25.173000",
          "_new"=>false,
          "keywords"=>
           ["@ricoarcha",
            "@thiomilan",
            "dmn",
            "oi",
            "lo",
            "rank?siap",
            "dota",
            "gag?"],
          "text"=>"@ricoarcha @Thiomilan  dmn oi lo rank?siap dota gag?",
          "created_at"=>"Fri Mar 02 14:16:34 +0000 2012",
          "_id"=>572486}, ...
        ]
=end