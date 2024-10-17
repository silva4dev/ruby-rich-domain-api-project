# typed: true
# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../src/business/checkout/domain/entity/order_coupon'

class OrderCouponTest < Minitest::Test
  def setup
    @code = 'SAVE20'
    @percentage = 20.0
    @order_coupon = Checkout::Domain::Entity::OrderCoupon.new(@code, @percentage)
  end

  def test_initialize
    assert_equal @code, @order_coupon.code
    assert_equal @percentage, @order_coupon.percentage
  end

  def test_get_discount
    total_amount = 100.0
    expected_discount = 20.0
    assert_equal expected_discount, @order_coupon.get_discount(total_amount)

    total_amount = 50.0
    expected_discount = 10.0
    assert_equal expected_discount, @order_coupon.get_discount(total_amount)
  end

  def test_get_discount_with_zero_total
    total_amount = 0.0
    expected_discount = 0.0
    assert_equal expected_discount, @order_coupon.get_discount(total_amount)
  end
end
