# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../domain/repository/city_repository'
require_relative '../domain/entity/distance_calculator'
require_relative '../domain/entity/freight_calculator'

module Freight
  module Application
    class CalculateFreight
      extend T::Sig

      sig { params(city_repository: Domain::Repository::CityRepository).void }
      def initialize(city_repository)
        @city_repository = city_repository
      end

      sig { params(input: Input).returns(Output) }
      def execute(input)
        from = @city_repository.get_by_zipcode(input.from)
        to = @city_repository.get_by_zipcode(input.to)
        distance = Domain::Entity::DistanceCalculator.calculate(from.coordinate, to.coordinate)
        total = 0.0
        input.order_items.each do |order_item|
          total += Domain::Entity::FreightCalculator.calculate(distance, order_item.volume.to_f, order_item.density) * order_item.quantity
        end
        total = (total * 100).round / 100.0
        Output.new(total: total)
      end

      class Input < T::Struct
        const :from, String
        const :to, String
        const :order_items, T::Array[OrderItem]
      end

      class OrderItem < T::Struct
        const :volume, Float
        const :density, Float
        const :quantity, Integer
      end

      class Output < T::Struct
        const :total, Float
      end
    end
  end
end
