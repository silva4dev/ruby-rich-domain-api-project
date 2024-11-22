# typed: true
# frozen_string_literal: true

require_relative '../../../../../src/business/freight/domain/entity/freight_calculator'
require_relative '../../../../test_helper'

module Freight
  module Domain
    module Entity
      class FreightCalculatorTest < Minitest::Test
        def test_calculate_zero_freight
          assert_in_delta(0.0, FreightCalculator.calculate(0.0, 10.0, 100.0))
          assert_in_delta(0.0, FreightCalculator.calculate(10.0, 0.0, 100.0))
          assert_in_delta(0.0, FreightCalculator.calculate(10.0, 10.0, 0.0))
        end

        def test_calculate_minimum_freight
          result = FreightCalculator.calculate(10.0, 1.0, 1.0)

          assert_in_delta(10.0, result)
        end

        def test_calculate_positive_freight
          result = FreightCalculator.calculate(10.0, 20.0, 50.0)

          assert_in_delta(100.0, result)
        end

        def test_calculate_freight_with_large_values
          result = FreightCalculator.calculate(1000.0, 2000.0, 10.0)

          assert_in_delta(200_000.0, result)
        end
      end
    end
  end
end
