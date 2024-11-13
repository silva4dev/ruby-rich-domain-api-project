# typed: true
# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/business/checkout/domain/entity/order_item'

module Checkout
  module Domain
    module Entity
      class OrderItemTest < Minitest::Test
        def setup
          @id_item = 1
          @price = 50.0
          @quantity = 2
          @order_item = OrderItem.new(@id_item, @price, @quantity)
        end

        def test_initialize
          assert_equal @id_item, @order_item.id_item
          assert_equal @price, @order_item.price
          assert_equal @quantity, @order_item.quantity
        end

        def test_initialize_with_invalid_quantity
          assert_raises(ArgumentError) do
            OrderItem.new(@id_item, @price, 0)
          end

          assert_raises(ArgumentError) do
            OrderItem.new(@id_item, @price, -1)
          end
        end

        def test_get_total
          expected_total = @price * @quantity

          assert_equal expected_total, @order_item.get_total
        end
      end
    end
  end
end
