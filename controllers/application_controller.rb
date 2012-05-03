require 'sinatra/base'
require 'mustache/sinatra'
#Begin Warden
require 'sinatra'
require 'warden'
#require 'sinatra_warden'
#End Warden

class ApplicationController < Sinatra::Base
    # Middleware
    use Rack::Session::Cookie, :secret => "bigbrother"

    #Begin Warden
    register Sinatra::Warden

    use Warden::Manager do |manager|
        manager.default_strategies :password, :basic
        manager.failure_app = BadAuthenticationEndsUpHere
    end
    #END Warden

    # Extra Sinatra components
    # register Sinatra::MultiRoute
    # register Sinatra::ConfigFile

    # Set up Mustache
    register Mustache::Sinatra
    require_relative '../views/layout'

    # set folder for templates to ../views, but make the path absolute 
    set :views, File.expand_path('../../views', __FILE__)
    set :mustache, {
        :views     => views,
        :templates => views
    }

    # Set up public folder
    set :public_folder, File.expand_path('../../public', __FILE__)

    # Site specific settings
    set :title, "Social Media Analyser"

    # Configuration
    # config_file File.expand_path('../../settings.yml', __FILE__) 
    # configure do
    # end

    before do
        @session = session
    end

    # Index page
    get '/' do 
        mustache :index
    end
end
