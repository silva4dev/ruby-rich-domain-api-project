# typed: true
# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/business/checkout/domain/entity/order'
require_relative '../../../../../src/business/checkout/domain/entity/item'
require_relative '../../../../../src/business/checkout/domain/entity/order_coupon'
require_relative '../../../../../src/business/checkout/domain/entity/dimension'

class OrderTest < Minitest::Test
  def setup
    @order = Checkout::Domain::Entity::Order.new('123.456.789-09', Time.new(2023, 12, 25), 1)
    @item = Checkout::Domain::Entity::Item.new(1, 'Laptop', 3000.00, Checkout::Domain::Entity::Dimension.new(0.01, 0.5, 0.1, 2.0))
  end

  def test_initialize
    assert_instance_of Checkout::Domain::Entity::Order, @order
    assert_equal '123.456.789-09', @order.cpf.value
    assert_equal [], @order.order_items
    assert_equal 0.0, @order.freight
  end

  def test_add_item
    @order.add_item(@item, 2)

    assert_equal 1, @order.order_items.size
    assert_equal 2, @order.order_items.first.quantity
    assert_equal 6040.0, @order.get_total
  end

  def test_add_duplicate_item
    @order.add_item(@item, 2)

    assert_raises(RuntimeError, 'Duplicated item') do
      @order.add_item(@item, 1)
    end
  end
end
