# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../entity/city'

module Freight
  module Domain
    module Repository
      class CityRepository
        extend T::Sig

        sig { params(code: String).returns(Entity::City) }
        def get_by_zipcode(code)
          raise NotImplementedError
        end
      end
    end
  end
end
