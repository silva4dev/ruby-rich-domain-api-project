# typed: true
# frozen_string_literal: true

require_relative '../entity/order'

module Checkout
  module Domain
    module Repository
      class OrderRepository
        extend T::Sig

        sig { params(order: Entity::Order).void }
        def save(order)
          raise NotImplementedError
        end

        sig { returns(Integer) }
        def count
          raise NotImplementedError
        end

        sig { void }
        def clean
          raise NotImplementedError
        end

        sig { params(code: String).returns(Entity::Order) }
        def get(code)
          raise NotImplementedError
        end
      end
    end
  end
end
