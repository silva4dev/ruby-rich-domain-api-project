# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Checkout
  module Domain
    module Entity
      class OrderItem
        extend T::Sig

        sig { returns(Integer) }
        attr_reader :id_item

        sig { returns(Float) }
        attr_reader :price

        sig { returns(Integer) }
        attr_reader :quantity

        sig { params(id_item: Integer, price: Float, quantity: Integer).void }
        def initialize(id_item, price, quantity)
          raise ArgumentError, 'Invalid quantity' if quantity <= 0

          @id_item = id_item
          @price = price
          @quantity = quantity
        end

        sig { returns(Float) }
        def get_total
          @price * @quantity
        end
      end
    end
  end
end
