# typed: true
# frozen_string_literal: true

require_relative '../entity/item'

module Checkout
  module Domain
    module Repository
      class ItemRepository
        extend T::Sig

        sig { params(id_item: Integer).returns(Entity::Item) }
        def get_item(id_item)
          raise NotImplementedError
        end
      end
    end
  end
end
