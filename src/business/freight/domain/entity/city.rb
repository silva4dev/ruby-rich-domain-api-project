# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'coordinate'

module Freight
  module Domain
    module Entity
      class City
        extend T::Sig

        sig { returns(Integer) }
        attr_reader :id_city

        sig { returns(String) }
        attr_reader :name

        sig { returns(Float) }
        attr_reader :lat, :long

        sig { returns(Coordinate) }
        attr_reader :coordinate

        sig { params(id_city: Integer, name: String, lat: Float, long: Float).void }
        def initialize(id_city, name, lat, long)
          @id_city = id_city
          @name = name
          @lat = lat
          @long = long
          @coordinate = Coordinate.new(lat, long)
        end
      end
    end
  end
end
