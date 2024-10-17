# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Checkout
  module Domain
    module Entity
      class OrderCode
        extend T::Sig

        sig { returns(String) }
        attr_reader :value

        sig { params(date: Time, sequence: Integer).void }
        def initialize(date, sequence)
          @value = generate_code(date, sequence)
        end

        sig { params(date: Time, sequence: Integer).returns(String) }
        def generate_code(date, sequence)
          year = date.year.to_s[-2..]
          sequence_str = sequence.to_s.rjust(8, '0')
          result = "#{year}#{sequence_str}"[-10..]
          T.must(result)
        end
      end
    end
  end
end
