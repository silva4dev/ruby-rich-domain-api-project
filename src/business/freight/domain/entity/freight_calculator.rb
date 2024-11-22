# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Freight
  module Domain
    module Entity
      class FreightCalculator
        extend T::Sig

        MIN_FREIGHT = 10.0

        sig { params(distance: Float, volume: Float, density: Float).returns(Float) }
        def self.calculate(distance, volume, density)
          freight = volume * distance * (density / 100.0)
          return 0.0 if freight.zero?

          [freight, MIN_FREIGHT].max
        end
      end
    end
  end
end
