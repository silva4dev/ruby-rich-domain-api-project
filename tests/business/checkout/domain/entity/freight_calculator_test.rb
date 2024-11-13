# typed: true
# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/business/checkout/domain/entity/freight_calculator'
require_relative '../../../../../src/business/checkout/domain/entity/item'
require_relative '../../../../../src/business/checkout/domain/entity/dimension'

module Checkout
  module Domain
    module Entity
      class FreightCalculatorTest < Minitest::Test
        def setup
          @dimension = Dimension.new(100.0, 200.0, 300.0, 600.0)
          @item = Item.new(1, 'Laptop', 3000.00, @dimension)
        end

        def test_calculate_freight_with_positive_density
          freight = FreightCalculator.calculate(@item)

          assert_in_delta 6000.0, freight, 0.01
        end

        def test_calculate_freight_with_zero_density
          dimension_zero_volume = Dimension.new(0.0, 0.0, 0.0, 600.0)
          item_zero_volume = Item.new(2, 'Item Zero Volume', 1000.00, dimension_zero_volume)

          freight = FreightCalculator.calculate(item_zero_volume)

          assert_in_delta(0.0, freight)
        end

        def test_calculate_freight_below_minimum
          dimension_low_density = Dimension.new(1.0, 1.0, 1.0, 0.001)
          item_low_density = Item.new(3, 'Item Baixa Densidade', 50.00, dimension_low_density)

          freight = FreightCalculator.calculate(item_low_density)

          assert_in_delta(10.0, freight)
        end
      end
    end
  end
end
