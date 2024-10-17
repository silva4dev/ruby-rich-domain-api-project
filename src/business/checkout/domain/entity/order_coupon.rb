# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Checkout
  module Domain
    module Entity
      class OrderCoupon
        extend T::Sig

        sig { returns(String) }
        attr_reader :code

        sig { returns(Float) }
        attr_reader :percentage

        sig { params(code: String, percentage: Float).void }
        def initialize(code, percentage)
          @code = code
          @percentage = percentage
        end

        sig { params(total: Float).returns(Float) }
        def get_discount(total)
          (total * @percentage) / 100
        end
      end
    end
  end
end
