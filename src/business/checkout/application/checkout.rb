# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../domain/repository/item_repository'
require_relative '../domain/repository/order_repository'

module Checkout
  module Application
    class Checkout
      extend T::Sig

      sig { params(item_repository: Domain::Repository::ItemRepository, order_repository: Domain::Repository::OrderRepository).void }
      def initialize(item_repository, order_repository)
        @item_repository = item_repository
        @order_repository = order_repository
      end

      sig { params(input: Input).returns(Output) }
      def execute(input)
        sequence = @order_repository.count + 1
        order = Domain::Entity::Order.new(input.cpf, input.date.to_time, sequence)
        input.order_items.each do |order_item|
          item = @item_repository.get_item(order_item[:id_item])
          order.add_item(item, order_item[:quantity])
        end
        @order_repository.save(order)
        total = order.get_total
        Output.new(code: order.get_code, total: total)
      end

      class Input < T::Struct
        const :cpf, String
        const :date, Date
        const :order_items, T::Array[{ id_item: Integer, quantity: Integer }]
      end

      class Output < T::Struct
        const :code, String
        const :total, Float
      end
    end
  end
end
