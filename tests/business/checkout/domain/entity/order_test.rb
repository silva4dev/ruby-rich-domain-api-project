# typed: true
# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/business/checkout/domain/entity/order'
require_relative '../../../../../src/business/checkout/domain/entity/item'
require_relative '../../../../../src/business/checkout/domain/entity/order_coupon'
require_relative '../../../../../src/business/checkout/domain/entity/dimension'

module Checkout
  module Domain
    module Entity
      class OrderTest < Minitest::Test
        def setup
          @order = Order.new('123.456.789-09', Time.new(2023, 12, 25), 1)
          @item = Item.new(1, 'Laptop', 3000.00, Dimension.new(0.01, 0.5, 0.1, 2.0))
        end

        def test_initialize
          assert_instance_of Order, @order
          assert_equal '123.456.789-09', @order.cpf.value
          assert_empty @order.order_items
          assert_in_delta(0.0, @order.freight)
        end

        def test_add_item
          @order.add_item(@item, 2)

          assert_equal 1, @order.order_items.size
          assert_equal 2, @order.order_items.first.quantity
          assert_in_delta(6040.0, @order.get_total)
        end

        def test_add_duplicate_item
          @order.add_item(@item, 2)

          assert_raises(RuntimeError, 'Duplicated item') do
            @order.add_item(@item, 1)
          end
        end
      end
    end
  end
end
