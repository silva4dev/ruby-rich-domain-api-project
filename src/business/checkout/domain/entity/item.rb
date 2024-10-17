# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'dimension'
require_relative 'order_item'

module Checkout
  module Domain
    module Entity
      class Item
        extend T::Sig

        sig { returns(Integer) }
        attr_reader :id_item

        sig { returns(String) }
        attr_reader :description

        sig { returns(Float) }
        attr_reader :price

        sig { returns(Dimension) }
        attr_reader :dimension

        sig { params(id_item: Integer, description: String, price: Float, dimension: Dimension).void }
        def initialize(id_item, description, price, dimension = Dimension.new(0.0, 0.0, 0.0, 0.0))
          @id_item = id_item
          @description = description
          @price = price
          @dimension = dimension
        end

        sig { returns(Float) }
        def get_volume
          @dimension.get_volume
        end

        sig { returns(Float) }
        def get_density
          @dimension.get_density
        end

        sig { params(quantity: Integer).returns(OrderItem) }
        def create_order_item(quantity)
          OrderItem.new(@id_item, @price, quantity)
        end
      end
    end
  end
end
