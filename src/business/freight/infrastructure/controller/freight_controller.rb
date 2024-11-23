# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../http/http'
require_relative '../database/connection'
require_relative '../repository/city_repository_database'

module Freight
  module Infrastructure
    module Controller
      class FreightController
        extend T::Sig

        sig { params(http: Freight::Infrastructure::Http::HttpAdapter, connection: Freight::Infrastructure::Database::Connection).void }
        def initialize(http, connection)
          http.on('post', '/calculateFreight', lambda { |_, body|
            city_repository = Repository::CityRepositoryDatabase.new(connection)
            calculate_freight = Application::CalculateFreight.new(city_repository)
            output = calculate_freight.execute(body)
            output
          })
        end
      end
    end
  end
end
