# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../../../domain/entity/item'
require_relative '../../../domain/repository/item_repository'
require_relative '../../../domain/entity/dimension'
require_relative '../../database/connection'

module Checkout
  module Infrastructure
    module Repository
      module Database
        class ItemRepositoryDatabase < Domain::Repository::ItemRepository
          extend T::Sig

          sig { params(connection: Checkout::Infrastructure::Database::Connection).void }
          def initialize(connection)
            super()
            @connection = connection
          end

          sig { params(id_item: Integer).returns(Domain::Entity::Item) }
          def get_item(id_item)
            result = @connection.query('SELECT * FROM rich-db.item WHERE id_item = $1', [id_item])
            item_data = result.first
            Domain::Entity::Item.new(
              item_data['id_item'], item_data['description'], item_data['price'].to_f,
              Domain::Entity::Dimension.new(item_data['width'], item_data['height'], item_data['length'], item_data['weight'])
            )
          end
        end
      end
    end
  end
end
