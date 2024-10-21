# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../domain/repository/item_repository'
require_relative 'gateway/calculate_freight_gateway'

module Checkout
  module Application
    class SimulateFreight
      extend T::Sig

      sig { params(item_repository: Domain::Repository::ItemRepository, calculate_freight_gateway: Gateway::CalculateFreightGateway).void }
      def initialize(item_repository, calculate_freight_gateway)
        @item_repository = item_repository
        @calculate_freight_gateway = calculate_freight_gateway
      end

      sig { params(input: Input).returns(Output) }
      def execute(input)
        order_items = []
        input.order_items.each do |order_item|
          item = @item_repository.get_item(order_item[:idItem])
          order_items.push({
            volume: item.get_volume,
            density: item.get_density,
            quantity: order_item[:quantity]
          })
        end
        freight_input = Gateway::CalculateFreightGateway::Input.new(
          from: input.from,
          to: input.to,
          order_items: order_items
        )
        output = @calculate_freight_gateway.calculate(freight_input)
        Output.new(total: output.total)
      end

      class Input < T::Struct
        const :from, String
        const :to, String
        const :order_items, T::Array[{ idItem: Integer, quantity: Integer }]
      end

      class Output < T::Struct
        const :total, Float
      end
    end
  end
end
