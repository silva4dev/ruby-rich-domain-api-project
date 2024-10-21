# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../domain/entities/order'
require_relative '../domain/repository/item_repository'

module Checkout
  module Application
    class PreviewOrder
      extend T::Sig

      sig { params(item_repository: Domain::Repository::ItemRepository).void }
      def initialize(item_repository)
        @item_repository = item_repository
      end

      sig { params(input: Input).returns(Output) }
      def execute(input)
        order = Domain::Entity::Order.new(input.cpf)
        input.order_items.each do |order_item|
          item = @item_repository.get_item(order_item[:idItem])
          order.add_item(item, order_item[:quantity])
        end
        total = order.get_total
        Output.new(total: total)
      end

      class Input < T::Struct
        const :cpf, String
        const :order_items, T::Array[{ idItem: Integer, quantity: Integer }]
      end

      class Output < T::Struct
        const :total, Float
      end
    end
  end
end
