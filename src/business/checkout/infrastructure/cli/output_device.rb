# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Checkout
  module Infrastructure
    module Cli
      class OutputDevice
        extend T::Sig

        sig { params(text: String).void }
        def write(text)
          raise NotImplementedError
        end
      end
    end
  end
end
