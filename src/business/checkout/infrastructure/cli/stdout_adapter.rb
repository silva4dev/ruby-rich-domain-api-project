# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'output_device'

module Checkout
  module Infrastructure
    module Cli
      class StdoutAdapter < OutputDevice
        extend T::Sig

        sig { override.params(text: String).void }
        def write(text)
          $stdout.write(text)
        end
      end
    end
  end
end
