# typed: true
# frozen_string_literal: true

require_relative '../../../../../src/business/freight/domain/entity/distance_calculator'
require_relative '../../../../../src/business/freight/domain/entity/coordinate'
require_relative '../../../../test_helper'

module Freight
  module Domain
    module Entity
      class DistanceCalculatorTest < Minitest::Test
        def setup
          @coordinate1 = Coordinate.new(12.34, 56.78)
          @coordinate2 = Coordinate.new(12.34, 56.78)
          @coordinate3 = Coordinate.new(13.34, 57.78)
        end

        def test_calculate_same_coordinates
          assert_in_delta(0.0, DistanceCalculator.calculate(@coordinate1, @coordinate2))
        end

        def test_calculate_different_coordinates
          result = DistanceCalculator.calculate(@coordinate1, @coordinate3)

          assert_instance_of Float, result
          assert_operator result, :>, 0
        end

        def test_calculate_distance
          coordinate1 = Coordinate.new(48.8566, 2.3522)  # Paris
          coordinate2 = Coordinate.new(51.5074, -0.1278) # London

          distance = DistanceCalculator.calculate(coordinate1, coordinate2)

          assert_in_delta 344.0, distance, 5.0 # Allowing a delta of 5 km
        end
      end
    end
  end
end
