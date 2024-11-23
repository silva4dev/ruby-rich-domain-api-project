# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../../domain/entity/city'
require_relative '../../domain/repository/city_repository'
require_relative '../database/connection'

module Freight
  module Infrastructure
    module Repository
      class CityRepositoryDatabase < Domain::Repository::CityRepository
        extend T::Sig

        sig { params(connection: Database::Connection).void }
        def initialize(connection)
          super()
          @connection = connection
        end

        sig { params(code: String).returns(Domain::Entity::City) }
        def get_by_zipcode(code)
          city_data = @connection.query(
            "SELECT id_city, name, lat, long
             FROM rich-db.zipcode
             JOIN rich-db.city USING (id_city)
             WHERE code = $1", 
             [code]
          ).first
        
          raise StandardError, 'City not found' unless city_data
          
          Domain::Entity::City.new(
            city_data['id_city'],
            city_data['name'],
            city_data['lat'].to_f,
            city_data['long'].to_f
          )
        end
      end
    end
  end
end
