# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'
require 'date'

require_relative 'order_coupon'

module Checkout
  module Domain
    module Entity
      class Coupon
        extend T::Sig

        sig { returns(String) }
        attr_reader :code

        sig { returns(Float) }
        attr_reader :percentage

        sig { returns(Date) }
        attr_reader :expire_date

        sig { params(code: String, percentage: Float, expire_date: Date).void }
        def initialize(code:, percentage:, expire_date:)
          @code = code
          @percentage = percentage.to_f
          @expire_date = expire_date
        end

        sig { params(date: Date).returns(T::Boolean) }
        def expired?(date)
          expire_date < date
        end

        sig { params(total: Float).returns(Float) }
        def discount(total)
          (total * percentage) / 100.0
        end

        sig { returns(OrderCoupon) }
        def create_order_coupon
          OrderCoupon.new(code, percentage)
        end
      end
    end
  end
end
