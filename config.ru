require 'sinatra/base'

dir = File.dirname(__FILE__)
Dir.glob("#{dir}/{helpers,controllers}/*.rb").each { |file| require file }

run Rack::Cascade.new [AuthenticationController, UserController, TaggingController, EvaluateController, ResultsController]