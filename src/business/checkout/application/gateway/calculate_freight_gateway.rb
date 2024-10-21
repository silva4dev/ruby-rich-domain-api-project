# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Checkout
  module Application
    module Gateway
      class CalculateFreightGateway
        extend T::Sig

        sig { params(input: Input).returns(Output) }
        def calculate(input)
          raise NotImplementedError
        end

        class Input < T::Struct
          const :from, String
          const :to, String
          const :order_items, T::Array[{ volume: Float, density: Float, quantity: Integer }]
        end

        class Output < T::Struct
          const :total, Float
        end
      end
    end
  end
end
