# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Freight
  module Domain
    module Entity
      class Zipcode
        extend T::Sig

        sig { returns(String) }
        attr_reader :code, :street, :neighborhood

        sig { returns(Integer) }
        attr_reader :id_city

        sig { params(code: String, id_city: Integer, street: String, neighborhood: String).void }
        def initialize(code, id_city, street, neighborhood)
          @code = code
          @id_city = id_city
          @street = street
          @neighborhood = neighborhood
        end
      end
    end
  end
end
