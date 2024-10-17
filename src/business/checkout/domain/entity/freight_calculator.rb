# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'item'

module Checkout
  module Domain
    module Entity
      class FreightCalculator
        extend T::Sig

        MIN_FREIGHT = 10.0

        sig { params(item: Item).returns(Float) }
        def self.calculate(item)
          freight = item.get_volume * 1000 * (item.get_density / 100.0)
          return 0.0 if freight.zero?

          [freight, MIN_FREIGHT].max
        end
      end
    end
  end
end
