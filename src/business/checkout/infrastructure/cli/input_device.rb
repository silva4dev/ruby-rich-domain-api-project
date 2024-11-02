# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

module Checkout
  module Infrastructure
    module Cli
      class InputDevice
        extend T::Sig

        sig { params(callback: T.proc.params(text: T.untyped).void).void }
        def on_data(callback)
          raise NotImplementedError
        end
      end
    end
  end
end
