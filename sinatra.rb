require 'bundler/setup'

require 'sinatra'
require 'logger'

module PDUs
  class App < Sinatra::Base

    def initialize(app = nil, params = {})
      super(app)
      logger = Logger.new(STDOUT)

    end

    get "/" do
      erb :"index.html"
    end

    get "/test" do
      erb :"test.html"
    end

    get "/assets/js/application.js" do
      content_type :js
      puts "require js"
      @scheme = ENV['RACK_ENV'] == "production" ? "wss://" : "ws://"
      erb :"application.js"
    end

    get "/assets/js/application_test.js" do
      content_type :js
      puts "require js"
      @scheme = ENV['RACK_ENV'] == "production" ? "wss://" : "ws://"
      erb :"application_test.js"
    end
  end
end
