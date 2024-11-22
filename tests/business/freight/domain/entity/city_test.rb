# typed: true
# frozen_string_literal: true

require_relative '../../../../../src/business/freight/domain/entity/city'
require_relative '../../../../test_helper'

module Freight
  module Domain
    module Entity
      class CityTest < Minitest::Test
        def setup
          @city = City.new(1, 'Test City', 12.34, 56.78)
        end

        def test_initialization
          assert_equal 1, @city.id_city
          assert_equal 'Test City', @city.name
          assert_in_delta(12.34, @city.lat)
          assert_in_delta(56.78, @city.long)
        end

        def test_coordinate_initialization
          coordinate = @city.coordinate

          assert_instance_of Coordinate, coordinate
          assert_in_delta(12.34, coordinate.lat)
          assert_in_delta(56.78, coordinate.long)
        end
      end
    end
  end
end
