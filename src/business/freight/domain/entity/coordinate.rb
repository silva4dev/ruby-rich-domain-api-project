# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Freight
  module Domain
    module Entity
      class Coordinate
        extend T::Sig

        sig { returns(Float) }
        attr_reader :lat, :long

        sig { params(lat: Float, long: Float).void }
        def initialize(lat, long)
          @lat = lat
          @long = long
        end
      end
    end
  end
end
