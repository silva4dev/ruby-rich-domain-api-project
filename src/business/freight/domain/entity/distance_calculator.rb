# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'coordinate'

module Freight
  module Domain
    module Entity
      class DistanceCalculator
        extend T::Sig

        sig { params(from: Coordinate, to: Coordinate).returns(Float) }
        def self.calculate(from, to)
          return 0.0 if from.lat == to.lat && from.long == to.long

          radlat1 = (Math::PI * from.lat) / 180
          radlat2 = (Math::PI * to.lat) / 180
          theta = from.long - to.long
          radtheta = (Math::PI * theta) / 180

          dist = (Math.sin(radlat1) * Math.sin(radlat2)) +
                 (Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta))

          dist = 1.0 if dist > 1.0
          dist = Math.acos(dist)
          dist = (dist * 180) / Math::PI
          dist = dist * 60 * 1.1515
          dist * 1.609344
        end
      end
    end
  end
end
