# typed: true
# frozen_string_literal: true

require 'hanami/api'

module Infrastructure
  module Http
    class Server < Hanami::API
      get '/' do
        { message: 'Hello World!' }.to_json
      end
    end
  end
end

Rack::Server.start(app: Infrastructure::Http::Server, Port: 5000) if $PROGRAM_NAME == __FILE__
