# typed: true
# frozen_string_literal: true

require 'date'

require_relative '../../../../test_helper'
require_relative '../../../../../src/business/checkout/domain/entity/coupon'

class CouponTest < Minitest::Test
  def setup
    @valid_coupon = Checkout::Domain::Entity::Coupon.new(
      code: 'SAVE10',
      percentage: 10.0,
      expire_date: Date.new(2024, 12, 31)
    )

    @expired_coupon = Checkout::Domain::Entity::Coupon.new(
      code: 'SAVE5',
      percentage: 5.0,
      expire_date: Date.new(2023, 1, 1)
    )
  end

  def test_coupon_initialization
    assert_equal 'SAVE10', @valid_coupon.code
    assert_equal 10.0, @valid_coupon.percentage
    assert_equal Date.new(2024, 12, 31), @valid_coupon.expire_date
  end

  def test_coupon_not_expired
    assert_equal false, @valid_coupon.expired?(Date.new(2024, 1, 1))
    assert_equal false, @valid_coupon.expired?(Date.new(2024, 12, 31))
  end

  def test_coupon_expired
    assert_equal true, @expired_coupon.expired?(Date.new(2023, 1, 2))
    assert_equal true, @expired_coupon.expired?(Date.new(2024, 1, 1))
  end

  def test_discount_calculation
    total = 1000.0
    discount = @valid_coupon.discount(total)

    assert_in_delta 100.0, discount, 0.01
  end

  def test_create_order_coupon
    order_coupon = @valid_coupon.create_order_coupon
    assert_instance_of Checkout::Domain::Entity::OrderCoupon, order_coupon
    assert_equal 'SAVE10', order_coupon.code
    assert_equal 10.0, order_coupon.percentage
  end
end
