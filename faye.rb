# app.rb
require 'bundler/setup'

require 'faye/websocket'
require 'rest-client'


module PDUs
  class PdusBackend
    
    def initialize(app)
      @app = app
      @clients = []
      base64 = File.read('.auth') 
      url = "https://helpdesk.grid5000.fr/supervision/lyon/wattmetre/GetWatts-json.php"
      Thread.new do
        while (true)
          json = RestClient.get url, {"Authorization" => "Basic #{base64}"} 
          @clients.each { |ws| ws.send(json)}
          sleep 1
        end
      end


    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env, nil, {ping: 15})

        ws.on :open do |event|
          puts "[open]"
          ws.send('hello from server')
          @clients << ws
          
        end

        ws.on :message do |event|
          p event
          ws.send(event.data)
        end

        ws.on :close do |event|
          p [:close, event.code, event.reason]
          ws = nil
        end

        # Return async Rack response
        ws.rack_response
      else
          @app.call(env)

      end
    end


  end
end
