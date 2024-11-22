# typed: true
# frozen_string_literal: true

require_relative '../../../../../src/business/freight/domain/entity/coordinate'
require_relative '../../../../test_helper'

module Freight
  module Domain
    module Entity
      class CoordinateTest < Minitest::Test
        def setup
          @coordinate = Coordinate.new(12.34, 56.78)
        end

        def test_initialization
          assert_in_delta(12.34, @coordinate.lat)
          assert_in_delta(56.78, @coordinate.long)
        end

        def test_lat_is_float
          assert_instance_of Float, @coordinate.lat
        end

        def test_long_is_float
          assert_instance_of Float, @coordinate.long
        end
      end
    end
  end
end
