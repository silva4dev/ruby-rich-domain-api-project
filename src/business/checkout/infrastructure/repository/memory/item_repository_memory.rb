# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../../../domain/entities/dimension'
require_relative '../../../domain/entities/item'
require_relative '../../../domain/repository/item_repository'

module Checkout
  module Infrastructure
    module Repository
      module Memory
        class ItemRepositoryMemory
          extend T::Sig

          sig { returns(T::Array[Domain::Entity::Item]) }
          attr_reader :items

          def initialize
            @items = [
              Domain::Entity::Item.new(1, 'Guitarra', 1000.0, Domain::Entity::Dimension.new(100.0, 30.0, 10.0, 3.0)),
              Domain::Entity::Item.new(2, 'Amplificador', 5000.0, Domain::Entity::Dimension.new(50.0, 50.0, 50.0, 20.0)),
              Domain::Entity::Item.new(3, 'Cabo', 30.0, Domain::Entity::Dimension.new(10.0, 10.0, 10.0, 1.0))
            ]
          end

          sig { params(id_item: Integer).returns(Domain::Entity::Item) }
          def get_item(id_item)
            found_item = @items.find { |item| item.id_item == id_item }
            raise 'Item not found' unless found_item

            found_item
          end
        end
      end
    end
  end
end
